//
//  CardGameVC.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit
import SnapKit
//import YandexMobileAds
import GoogleMobileAds

class CardGameVC: UIViewController {
    var interstitial: GADInterstitialAd?
    var rewardedAd: GADRewardedAd?
//    var myInterstitialAdLoader: InterstitialAdLoader?
//    var interstitialAd: InterstitialAd?
//    var rewardedAd: RewardedAd? // Для хранения вознаграждаемого объявления
//    var rewardedAdLoader: RewardedAdLoader? // Для загрузки объявления
//    private var isRewardResived = false
//    static var lastAdTime = Date()
    
    private var emitterLayer: CAEmitterLayer?

    private var cards: [Card] = []
    private let spacing: CGFloat = 10
    private var firstFlippedCardIndex: IndexPath?
    private var collectionView: UICollectionView!
    private var timeLabel: UILabel!
    private var errorsLabel: UILabel!

    let rulesButton = UIButton(type: .system)
    let revealCardsButton = UIButton(type: .system)
    let skipLevelButton = UIButton(type: .system)
   
    let revealBadgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true // По умолчанию скрыт
        return label
    }()
    
    let skipBadgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true // По умолчанию скрыт
        return label
    }()

    
    // game logic
    private var flipedCount = 0
    private var matchedCount = 0
    private var errorsCount: Int = 0
    private var isrevealed = false
    private var timer: Timer?
    private var startTime: Date?
    
    var isFirst = false
    var viewModel: CardViewModel
    var isStoreOpened = false
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !PurchasedLogicHelper.shared.getShowAdds() {
            loadInterstitialAd()
        }
        loadRewardedAdRevard()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirst {
            showAlert(title: "Cards.Rulls".localized(), message: "") {  }
        }
        errorsCount = 0
        startTimer()
        
        updateRevealBadge(with: CoinsHelper.shared.getRevil())
        updateSkipBadge(with: CoinsHelper.shared.getSkips())
        
        if isStoreOpened {
            isStoreOpened = false
            viewModel = CardModel().data[CardGameHelper.shared.currentLevel]
            setupCards()
            collectionView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    private func showAlert(title: String, message: String, isCancel: Bool = false, action: @escaping (() -> Void)) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in
            action()
        }))
        
        if isCancel {
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        guard let startTime = startTime else { return }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        let roundedElapsedTime = Int(round(elapsedTime))
        timeLabel.text = "  " + "Cards.Time".localized() + "\(roundedElapsedTime).0" + "    "
        timeLabel.textColor = elapsedTime < CardGameHelper.shared.maxSecondsCount ? .white : .red
    }
    
    private func getCurrentTime() -> TimeInterval? {
        guard let startTime = startTime else { return nil }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        return elapsedTime
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func setup() {
        // Создание UIImageView для фона
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "mainIcon1")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        view.layoutIfNeeded()

        setupLabels()
        setupCollection()
        setupCards()
        setupNavigationBarButtons()
        
        if CardGameHelper.shared.currentLevel == 3 || CardGameHelper.shared.currentLevel == 11 || CardGameHelper.shared.currentLevel == 40 {
            showAlert(
                title: "StoreScreen.ChangeCards.Title".localized(),
                message: "StoreScreen.ChangeCards.Message".localized(),
                isCancel: true) { [weak self] in
                    self?.isStoreOpened = true
                    let storeScreenVC = StoreScreenVC()
//                    storeScreenVC.isNeedScrollToCards = true
                    self?.navigationController?.pushViewController(storeScreenVC, animated: true)
                }
        }
    }
    
    private func setupLabels() {
        // Настройка timeLabel
        timeLabel = UILabel()
        timeLabel.text = "  " + "Cards.Time".localized() + "\(getCurrentTime() ?? 0)" + "    "
        timeLabel.textAlignment = .center
        timeLabel.numberOfLines = 1
        timeLabel.font = UIFont.simpleFont.withSize(16)
        timeLabel.textColor = .white // Белый текст для лучшего контраста
        
        // Настройка фона
        timeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Полупрозрачный черный
        timeLabel.layer.cornerRadius = 10
        timeLabel.clipsToBounds = true
        
        view.addSubview(timeLabel)

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        
        // Настройка errorsLabel
        errorsLabel = UILabel()
        errorsLabel.text = "  " + "Cards.Errors".localized() + "\(errorsCount)" + "    "
        errorsLabel.textAlignment = .center
        errorsLabel.numberOfLines = 1
        errorsLabel.font = UIFont.simpleFont.withSize(16)
        errorsLabel.textColor = .white // Белый текст для лучшего контраста
        
        // Настройка фона
        errorsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Полупрозрачный черный
        errorsLabel.layer.cornerRadius = 10
        errorsLabel.clipsToBounds = true
        
        view.addSubview(errorsLabel)

        errorsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    
    private func setupCollection() {
        // Создание UICollectionViewLayout
        let layout = UICollectionViewFlowLayout()
        
        // Расчет размеров ячеек
        let totalSpacing = spacing * CGFloat(viewModel.numberOfColumns - 1)
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - 20 - totalSpacing) / CGFloat(viewModel.numberOfColumns)
        let itemHeight: CGFloat = itemWidth + 20
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing // Промежутки между ячейками
        layout.minimumLineSpacing = spacing // Промежутки между строками

        // Создание UICollectionView с заданным layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        // Установка ограничений для UICollectionView
        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(rulesLabel.snp.bottom).offset(5)
//            make.centerX.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(itemHeight * CGFloat(viewModel.numberOfRows) + (spacing * CGFloat(viewModel.numberOfRows - 1)))
        }
    }

    private func setupCards() {
        cards = viewModel.data.shuffled().shuffled().shuffled() 
//        cards = viewModel.data
    }
    
    private func setupNavigationBarButtons() {
        rulesButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        rulesButton.tintColor = .white
        rulesButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        
        revealCardsButton.setImage(UIImage(systemName: "eye"), for: .normal)
        revealCardsButton.tintColor = .white
        revealCardsButton.addTarget(self, action: #selector(revealCardsButtonTapped), for: .touchUpInside)
        
        skipLevelButton.setImage(UIImage(systemName: "chevron.right.2"), for: .normal)
        skipLevelButton.tintColor = .white
        skipLevelButton.addTarget(self, action: #selector(skipLevelButtonTapped), for: .touchUpInside)
        
        // Добавляем бейдж к revealCardsButton
        revealCardsButton.addSubview(revealBadgeLabel)
        
        // Настройка constraints для бейджа
        revealBadgeLabel.snp.makeConstraints { make in
            make.top.equalTo(revealCardsButton.snp.top).offset(-5)
            make.trailing.equalTo(revealCardsButton.snp.trailing).offset(5)
            make.width.height.equalTo(20) // Круглый бейдж 20x20
        }

        // Добавляем бейдж к revealCardsButton
        skipLevelButton.addSubview(skipBadgeLabel)
        
        // Настройка constraints для бейджа
        skipBadgeLabel.snp.makeConstraints { make in
            make.top.equalTo(skipLevelButton.snp.top).offset(-5)
            make.trailing.equalTo(skipLevelButton.snp.trailing).offset(5)
            make.width.height.equalTo(20) // Круглый бейдж 20x20
        }
        
        // Создаем UIStackView для размещения кнопок в центре навигейшен бара
        let buttonStackView = UIStackView(arrangedSubviews: [rulesButton, revealCardsButton, skipLevelButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.alignment = .center
        buttonStackView.distribution = .equalSpacing
        
        // Устанавливаем StackView как titleView
        navigationItem.titleView = buttonStackView
    }

    func updateRevealBadge(with count: Int) {
        if count > 0 {
            revealBadgeLabel.text = "\(count)"
            revealBadgeLabel.isHidden = false
        } else {
            revealBadgeLabel.isHidden = true
        }
    }
    
    func updateSkipBadge(with count: Int) {
        if count > 0 {
            skipBadgeLabel.text = "\(count)"
            skipBadgeLabel.isHidden = false
        } else {
            skipBadgeLabel.isHidden = true
        }
    }
    
    @objc private func rulesButtonTapped() {
        showAlert(title: "Cards.Rulls".localized(), message: "") { }
    }

    @objc private func revealCardsButtonTapped() {
        guard CoinsHelper.shared.getRevil() < 1 else {
            updateRevealBadge(with: CoinsHelper.shared.getRevil() - 1)
            CoinsHelper.shared.saveRevil(CoinsHelper.shared.getRevil() - 1)
            startRevil()
            return
        }
        
        let text = "Cards.Revil".localized() + " \(AddsCoinsConst.revealCardsCost) " + "Cards.Coins".localized()
        showAlert(title: text, message: "", isCancel: true) { [weak self] in
            guard
                let self,
                CoinsHelper.shared.getSpecialCoins() >= AddsCoinsConst.revealCardsCost
            else {
                self?.showAlertNotEnothMoney()
                return
            }
            
            CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() - AddsCoinsConst.revealCardsCost)
            NotificationCenter.default.post(name: Notification.Name("changeCurrentFont"), object: nil)
            self.startRevil()
        }
    }

    private func startRevil() {
        self.collectionView.visibleCells.forEach { cell in
            guard
                let cell = cell as? CardCell,
                !cell.isMatch,
                !cell.isFliped
            else { return }
            
            self.isrevealed = true
            cell.flip()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                cell.flip()
                self.isrevealed = false
            }
        }
    }
    
    private func showAlertNotEnothMoney() {
        let alert = UIAlertController(
            title: "StoreScreen.Buy.Coins.NotEnath.Title".localized(),
            message: "StoreScreen.Buy.Coins.NotEnath.Message".localized(),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "StoreScreen.BlockAddsCell.cancel".localized(),
            style: .cancel,
            handler: nil))
        
        alert.addAction(UIAlertAction(
            title: "OK".localized(),
            style: .destructive,
            handler: { [weak self] _ in
                let storeScreenVC = StoreScreenVC()
                self?.navigationController?.pushViewController(storeScreenVC, animated: true)
            }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func skipLevelButtonTapped() {
        guard CoinsHelper.shared.getSkips() < 1 else {
            updateSkipBadge(with: CoinsHelper.shared.getSkips() - 1)
            CoinsHelper.shared.saveSkips(CoinsHelper.shared.getSkips() - 1)
            levelfinished()
            return
        }
        
        showAlert(title: "Cards.Skip".localized(), message: "", isCancel: true) { [weak self] in
            self?.showRewardedAdRevard()
        }
    }
    
    private func levelfinished() {
        CardGameHelper.shared.updateFinishedLevel(CardGameHelper.shared.currentLevel)
        
        let time = getCurrentTime() ?? 0
        stopTimer()
        CardGameHelper.shared.updateLevelProgres(
            with: LevelProgresCard(
                isFinished: true,
                isError: errorsCount < CardGameHelper.shared.maxErrorCount,
                isTime: time < CardGameHelper.shared.maxSecondsCount
                ),
            at: CardGameHelper.shared.currentLevel
        )
        
        let levelcomplitedView = LevelcomplitedView()
        levelcomplitedView.clipsToBounds = true
        levelcomplitedView.layer.cornerRadius = 20
        levelcomplitedView.alpha = 0 // Устанавливаем начальную прозрачность в 0
        levelcomplitedView.layer.borderColor = UIColor.black.cgColor
        levelcomplitedView.layer.borderWidth = 0.5
        
        levelcomplitedView.okDidTapHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
            self?.emitterLayer?.removeFromSuperlayer() // Удалить анимацию через 1 секунду
        }
                
        levelcomplitedView.setup(
            time: time,
            errors: errorsCount
        )
       
        view.addSubview(levelcomplitedView)
        startBubbleAnimation()

        // Устанавливаем начальные размеры и позицию
        levelcomplitedView.snp.makeConstraints { make in
            make.center.equalToSuperview() // Центрируем по центру экрана
            make.width.height.equalTo(0)  // Начальная ширина и высота равны 0
        }
        
        // Анимация изменения размеров и прозрачности
        UIView.animate(withDuration: 0.5, animations: {
            levelcomplitedView.alpha = 1 // Делаем видимым
            levelcomplitedView.snp.remakeConstraints { make in
                make.center.equalToSuperview() // Центрируем по центру экрана
                make.width.equalTo(UIScreen.main.bounds.width - 30)
//                make.height.equalTo(2 * UIScreen.main.bounds.height / 3)
            }
            self.view.layoutIfNeeded() // Обновляем макет
        })
        
        if CardGameHelper.shared.currentLevel == 2 {
            requestAppReview()
        } else if CardGameHelper.shared.currentLevel == 0 {
            if !RevardsHelper.shared.getFinishedRevards().contains(5) {
                RevardsHelper.shared.updateFinishedLevel(5)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title6".localized(),
                    subTitle: "RewardsScreen.SubTitle6".localized(),
                    image: UIImage(named: "trophy6")
                )
                
                view.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                view.bringSubviewToFront(trophyView)
            }
        } else if CardGameHelper.shared.currentLevel == 9 {
            if !RevardsHelper.shared.getFinishedRevards().contains(6) {
                RevardsHelper.shared.updateFinishedLevel(6)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title7".localized(),
                    subTitle: "RewardsScreen.SubTitle7".localized(),
                    image: UIImage(named: "trophy7")
                )
                
                view.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                view.bringSubviewToFront(trophyView)
            }
        } else if CardGameHelper.shared.currentLevel == 49 {
            if !RevardsHelper.shared.getFinishedRevards().contains(7) {
                RevardsHelper.shared.updateFinishedLevel(7)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title8".localized(),
                    subTitle: "RewardsScreen.SubTitle8".localized(),
                    image: UIImage(named: "trophy8")
                )
                
                view.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
            }
        }
    }
}

extension CardGameVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        let card = cards[indexPath.item]
        cell.configure(with: card, backImage: viewModel.backImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard flipedCount < 2, !isrevealed else { return }
        
        guard !cards[indexPath.item].isFlipped, !cards[indexPath.item].isMatched else { return }
        
        flipedCount += 1
        
        cards[indexPath.item].isFlipped = true
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        cell.flip()
        
        if let firstIndex = firstFlippedCardIndex {
            let firstCardIndex = firstIndex.item
            let secondCardIndex = indexPath.item
            
            let firstCard = cards[firstCardIndex]
            let secondCard = cards[secondCardIndex]
            
            if firstCard.id == secondCard.id {
                cards[firstCardIndex].isMatched = true
                cards[secondCardIndex].isMatched = true
                flipedCount = 0
                firstFlippedCardIndex = nil
                
                let firstCell = collectionView.cellForItem(at: firstIndex) as! CardCell
                firstCell.matched()
                cell.matched()
                matchedCount += 2
                if matchedCount >= cards.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.levelfinished()
                    }
                }
            } else {
                errorsCount += 1
                errorsLabel.text = "  " + "Cards.Errors".localized() + "\(errorsCount)" + "    "
                errorsLabel.textColor = errorsCount < CardGameHelper.shared.maxErrorCount ? .white : .red
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.cards[firstCardIndex].isFlipped = false
                    self.cards[secondCardIndex].isFlipped = false
                    
                    collectionView.performBatchUpdates({
                        collectionView.reloadItems(at: [firstIndex, indexPath])
                    }) { [weak self] _ in
                        self?.flipedCount = 0
                    }
                }
                firstFlippedCardIndex = nil
            }
        } else {
            firstFlippedCardIndex = indexPath
        }
    }
}

// MARK: - GooglAdds

extension CardGameVC: GADFullScreenContentDelegate {
    func loadInterstitialAd() {
        let adUnitID = "ca-app-pub-4833261880378078/7765163813" // Используйте тестовый идентификатор
        GADInterstitialAd.load(withAdUnitID: adUnitID, request: GADRequest()) { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error)")
                return
            }
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
            
            // Теперь объявление загружено, можно показать его
            if CardGameHelper.shared.isGamefirstOpend {
                CardGameHelper.shared.isGamefirstOpend = false
            } else {
                self?.showInterstitialAd()
            }
        }
    }
    
    func showInterstitialAd() {
        guard !PurchasedLogicHelper.shared.getShowAdds() else { return }

        if let interstitial = interstitial {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            // Показать следующий экран или выполнить другую задачу, если реклама не готова
//            transitionToNextScreen()
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad was dismissed")
        // Здесь нет необходимости вызывать loadInterstitialAd() напрямую
        // Вместо этого, загрузите новое объявление только когда это нужно
    }
    
    func transitionToNextScreen() {
        // Переход на другой экран
//        performSegue(withIdentifier: "ShowNextScreen", sender: self)
    }
}


// MARK: - GooglAdds Revard

extension CardGameVC {
    func adDidDismissFullScreenContentRevard(_ ad: GADFullScreenPresentingAd) {
        print("Ad was dismissed")
//        loadRewardedAd() // Загрузите новое объявление после показа текущего
    }
    
    func loadRewardedAdRevard(closure: (() -> Void)? = nil) {
                let adUnitID = "ca-app-pub-6969606246892234/1260840304" // todo
//        let adUnitID = "ca-app-pub-3940256099942544/1712485313" // test
        let request = GADRequest()
        
        GADRewardedAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error)")
                return
            }
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            
//            closure?()
        }
    }

    func showRewardedAdRevard() {
        if let rewardedAd = rewardedAd {
            rewardedAd.present(fromRootViewController: self) {
                // Это будет вызвано, когда пользователь получает вознаграждение
                let reward = rewardedAd.adReward
                print("User should receive \(reward.amount) \(reward.type)")
                self.giveRewardToUserRevard()
                self.loadRewardedAdRevard()
            }
        } else {
            // Покажите другой экран или выполните альтернативное действие
            print("Rewarded ad wasn't ready")
            let alert = UIAlertController(
                title: "Sorry, ads are not available at the moment.",
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in

            }))
            
            self.present(alert, animated: true, completion: nil)
//            loadRewardedAdRevard() {
//                self.showRewardedAdRevard()
//            }
        }
    }

    func giveRewardToUserRevard() {
        //  Логика для предоставления вознаграждения пользователю
        levelfinished()
    }
}

// MARK: - Level finished animation
extension CardGameVC {
    private func startBubbleAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitterLayer.emitterShape = .circle
        emitterLayer.emitterSize = CGSize(width: 40, height: 80) // Уменьшить размер эмиттера
        emitterLayer.emitterMode = .outline
        
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 1.5
        cell.velocity = view.bounds.width / 2
        cell.velocityRange = 50
        cell.emissionLatitude = 2 * CGFloat.pi
        cell.spinRange = 5
        cell.scale = 0.5
        cell.scaleRange = 0.25
        cell.alphaSpeed = -0.025
        emitterLayer.emitterCells = [cell]
        
        // Изменение цвета пузырьков
        if let originalImage = UIImage(systemName: "star.fill") {
            let ciImage = CIImage(image: originalImage)
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setValue(ciImage, forKey: kCIInputImageKey)
            colorFilter.setValue(CIColor(red: 1, green: 0.5, blue: 0, alpha: 0.8), forKey: "inputColor0") // Оранжево-красный полупрозрачный цвет
            colorFilter.setValue(CIColor(red: 0.6, green: 0, blue: 0.8, alpha: 0.5), forKey: "inputColor1") // Мягкий пурпурный полупрозрачный цвет
            
            guard let outputImage = colorFilter.outputImage else { return }
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                cell.contents = cgImage
            }
        }
        
        emitterLayer.emitterCells = [cell]
        self.emitterLayer = emitterLayer
        self.view.layer.addSublayer(emitterLayer)
    }
}

// Ad Yandex:

//extension CardGameVC: InterstitialAdDelegate, InterstitialAdLoaderDelegate {
//
//    func loadInterstitialAd() {
//        // Настроим Request Configuration для межстраничной рекламы
//        let requestConfiguration = AdRequestConfiguration(adUnitID: "R-M-13733254-2")
//        
//        // Инициализация и настройка загрузчика
//        myInterstitialAdLoader = InterstitialAdLoader()
//        myInterstitialAdLoader?.delegate = self
//        
//        // Загружаем объявление
//        myInterstitialAdLoader?.loadAd(with: requestConfiguration)
//    }
//    
//    func showInterstitialAd() {
//        guard
//            !PurchasedLogicHelper.shared.getShowAdds(),
//            Date().timeIntervalSince(CardGameVC.lastAdTime) > 120
//        else { return }
//        
//        CardGameVC.lastAdTime = Date()
//        if let interstitialAd = interstitialAd {
//            interstitialAd.show(from: self)
//        } else {
//            print("Interstitial ad wasn't ready")
//        }
//    }
//    
//    func interstitialAdDidDismiss(_ interstitialAd: YandexMobileAds.InterstitialAd) {
//        print("Interstitial ad was dismissed.")
//    }
//    
//    func interstitialAd(_ interstitialAd: InterstitialAd, didFailToShowWithError error: any Error) {
//        print("Interstitial Faild.")
//    }
//    
//    func interstitialAdDidClick(_ interstitialAd: YandexMobileAds.InterstitialAd) {
//        print("Interstitial ad clicked.")
//    }
//    
//    func interstitialAdLoader(_ adLoader: YandexMobileAds.InterstitialAdLoader, didLoad interstitialAd: YandexMobileAds.InterstitialAd) {
//        self.interstitialAd = interstitialAd
//        self.interstitialAd?.delegate = self
//        showInterstitialAd()
//    }
//    
//    func interstitialAdLoader(_ adLoader: YandexMobileAds.InterstitialAdLoader, didFailToLoadWithError error: YandexMobileAds.AdRequestError) {
//        print("Failed to load interstitial ad: \(error)")
//    }
//}
//
//// MARK: - YandexAds Reward
//
//extension CardGameVC: RewardedAdDelegate {
//    
//    func loadRewardedAdRevard() {
//        let requestConfiguration = AdRequestConfiguration(adUnitID: "R-M-13733254-3")
//        rewardedAdLoader = RewardedAdLoader()
//        rewardedAdLoader?.delegate = self
//        rewardedAdLoader?.loadAd(with: requestConfiguration)
//    }
//    
//    func showRewardedAdRevard() {
//        if let rewardedAd = rewardedAd {
//            rewardedAd.show(from: self)
//        } else {
//            showAlert(title: "Sorry", message: "No ads to show right now.") { }
//            print("Rewarded ad wasn't ready")
//        }
//    }
//    
//    func rewardedAd(_ rewardedAd: RewardedAd, didReward reward: any Reward) {
//        print("User should receive \(reward.amount) \(reward.type)")
//        isRewardResived = true
//    }
//    
//    func giveRewardToUser() {
//        levelfinished()
//    }
//    
//    func rewardedAdDidDismiss(_ rewardedAd: YandexMobileAds.RewardedAd) {
//        print("User should receive")
//        
//        if isRewardResived {
//            self.giveRewardToUser()
//            isRewardResived = false
//        }
//        loadRewardedAdRevard()
//    }
//}
//
//extension CardGameVC: RewardedAdLoaderDelegate {
//    func rewardedAdLoader(_ adLoader: YandexMobileAds.RewardedAdLoader, didLoad rewardedAd: YandexMobileAds.RewardedAd) {
//        self.rewardedAd = rewardedAd
//        self.rewardedAd?.delegate = self
//    }
//    
//    func rewardedAdLoader(_ adLoader: YandexMobileAds.RewardedAdLoader, didFailToLoadWithError error: YandexMobileAds.AdRequestError) {
//        print("Failed to load ad: \(error)")
//    }
//}
