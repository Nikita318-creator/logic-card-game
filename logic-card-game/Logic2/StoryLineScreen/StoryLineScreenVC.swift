//
//  StoryLineScreenVC.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit
import SnapKit
import GoogleMobileAds

class StoryLineScreenVC: UIViewController {
    var interstitial: GADInterstitialAd?
    var rewardedAd: GADRewardedAd?
    
    private var viewModel: StoryLineScreenViewModelProtocol {
        
        switch StoryLineHelper.shared.getStoryLineProgress() {
        case .storyLineGame1, .storyLine1:
            return StoryLineScreen1ViewModel()
        case .storyLine2, .storyLineGame2:
            return StoryLineScreen2ViewModel()
        case .storyLine3, .storyLineGame3:
            return StoryLineScreen3ViewModel()
        case .storyLine4, .storyLineGame4:
            return StoryLineScreen4ViewModel()
        case .storyLine5, .storyLineGame5:
            return StoryLineScreen5ViewModel()
        }
    }
    
    let storyLineScreenView = StoryLineScreenView(frame: .zero)
    let resultStoryLineScreenView = ResultStoryLineScreenView(frame: .zero)
    let resultStoryLineScreenView2 = ResultStoryLineScreenView(frame: .zero)
    let finalStoryLineView = FinalStoryLineView(frame: .zero)
    
    private let headerLabel = UILabel()
    private let rulesButton = UIButton(type: .system)
    private let revealCardsButton = UIButton(type: .system)
    private let skipLevelButton = UIButton(type: .system)
    
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
    
    var storyLineCardGameView: StoryLineCardGameView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание UIImageView для фона
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "mainIcon1")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.backgroundColor = .clear
        view.layoutIfNeeded()
        
        view.backgroundColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        loadRewardedAdRevard()
        if !PurchasedLogicHelper.shared.getShowAdds() {
            loadInterstitialAd()
        }
        start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateRevealBadge(with: CoinsHelper.shared.getRevil())
        updateSkipBadge(with: CoinsHelper.shared.getSkips())
    }
    
    private func start() {
        guard StoryLineHelper.shared.getStoryLineProgress() != .storyLineGame5 else {
            showFinalStoryLineView()
            return
        }

        setup()
        
        showResult()
        resultStoryLineScreenView.isHidden = true
        resultStoryLineScreenView2.isHidden = true
    }
    
    private func setup() {
        view.addSubview(storyLineScreenView)
        storyLineScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        StoryLineHelper.shared.saveCurrentquestionNumber(0)

        switch StoryLineHelper.shared.getStoryLineProgress() {
        case .storyLineGame1, .storyLineGame2, .storyLineGame3, .storyLineGame4, .storyLineGame5:
            showStoryLineCardGameView(currentLevel: 0)
            return
        case .storyLine1, .storyLine2, .storyLine3, .storyLine4, .storyLine5:
            break
        }
        
        let data = viewModel.data1[StoryLineHelper.shared.getCurrentquestionNumber()]
        storyLineScreenView.configure(question: data.question, answer1: data.answer1, answer2: data.answer2, image: data.image)
        storyLineScreenView.setupUI()
        
        storyLineScreenView.answerSelectedHandler = { [weak self] answerNumbwer in
            self?.neeDecidenextQuestion(answerNumbwer: answerNumbwer)
        }
        
        switch StoryLineHelper.shared.getStoryLineProgress() {
        case .storyLine1, .storyLineGame1, .storyLineGame2, .storyLineGame3, .storyLineGame4, .storyLineGame5:
            break
        case  .storyLine2:
            if !RevardsHelper.shared.getFinishedRevards().contains(0) {
                RevardsHelper.shared.updateFinishedLevel(0)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title1".localized(),
                    subTitle: "RewardsScreen.SubTitle1".localized(),
                    image: UIImage(named: "trophy1")
                )
                
                storyLineScreenView.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                storyLineScreenView.bringSubviewToFront(trophyView)
            }
        case .storyLine3:
            if !RevardsHelper.shared.getFinishedRevards().contains(1) {
                RevardsHelper.shared.updateFinishedLevel(1)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title2".localized(),
                    subTitle: "RewardsScreen.SubTitle2".localized(),
                    image: UIImage(named: "trophy2")
                )
                
                storyLineScreenView.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                storyLineScreenView.bringSubviewToFront(trophyView)
            }
        case .storyLine4:
            if !RevardsHelper.shared.getFinishedRevards().contains(2) {
                RevardsHelper.shared.updateFinishedLevel(2)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title3".localized(),
                    subTitle: "RewardsScreen.SubTitle3".localized(),
                    image: UIImage(named: "trophy3")
                )
                
                storyLineScreenView.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                storyLineScreenView.bringSubviewToFront(trophyView)
            }
        case .storyLine5:
            if !RevardsHelper.shared.getFinishedRevards().contains(3) {
                RevardsHelper.shared.updateFinishedLevel(3)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title4".localized(),
                    subTitle: "RewardsScreen.SubTitle4".localized(),
                    image: UIImage(named: "trophy4")
                )
                
                storyLineScreenView.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                storyLineScreenView.bringSubviewToFront(trophyView)
            }
        }
    }
    
    private func neeDecidenextQuestion(answerNumbwer: Int) {
        if StoryLineHelper.shared.getCurrentquestionNumber() >= 1 {
            storyLineScreenView.removeFromSuperview()
            self.navigationItem.hidesBackButton = true

            if answerNumbwer == 0 {
                resultStoryLineScreenView.isHidden = false
            } else {
                resultStoryLineScreenView2.isHidden = false
            }
            
            navigationItem.titleView = headerLabel
            headerLabel.textColor = .white
            headerLabel.font = UIFont.boldFont.withSize(36)
            headerLabel.text = "AI".localized()
            headerLabel.sizeToFit()

            // Кнопка "Далее" справа
            let nextButton = UIBarButtonItem(title: "Next".localized(), style: .plain, target: self, action: #selector(nextButtonTapped))
            nextButton.tintColor = .white
            navigationItem.rightBarButtonItem = nextButton
            
            showAlert(title: "Info".localized(), message: viewModel.Textbefore) { }
            
            return
        }
        
        StoryLineHelper.shared.saveCurrentquestionNumber(StoryLineHelper.shared.getCurrentquestionNumber() + 1)
        
        guard StoryLineHelper.shared.getStoryLineProgress() != .storyLine5 else { // - запускаем финальную главу!
            goToFinal(answerNumbwer: answerNumbwer)
            return
        }
        
        if StoryLineHelper.shared.getStoryLineProgress() == .storyLine3 {
            let result = answerNumbwer == 0 ? FinalResultType.type1 : FinalResultType.type2
            FinalStoryLineHelper.shared.saveFinalResultType(result)
        }
        
        let data = answerNumbwer == 0 ? viewModel.data1[StoryLineHelper.shared.getCurrentquestionNumber()] : viewModel.data2[StoryLineHelper.shared.getCurrentquestionNumber()]
        storyLineScreenView.configure(question: data.question, answer1: data.answer1, answer2: data.answer2, isFirstQuestion: false, image: data.image)
    }
    
    private func showResult() {
        view.addSubview(resultStoryLineScreenView)
        resultStoryLineScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        resultStoryLineScreenView.configure(
            firstMessages: viewModel.firstMessages,
            secondMessages: viewModel.secondMessages
        )
        
        view.addSubview(resultStoryLineScreenView2)
        resultStoryLineScreenView2.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        resultStoryLineScreenView2.configure(
            firstMessages: viewModel.firstMessages2,
            secondMessages: viewModel.secondMessages2
        )
    }

    @objc private func nextButtonTapped() {
        showAlert(title: "", message: viewModel.goToNextText) { [weak self] in
            
            switch StoryLineHelper.shared.getStoryLineProgress() {
            case .storyLine1:
                StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame1)
            case .storyLine2:
                self?.requestAppReview()
                StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame2)
            case .storyLine3:
                StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame3)
            case .storyLine4:
                StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame4)
            case .storyLine5:
                StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame5)
            case .storyLineGame2, .storyLineGame1, .storyLineGame3, .storyLineGame4, .storyLineGame5:
                break
            }
                
            self?.navigationItem.titleView = nil
            self?.navigationItem.rightBarButtonItem = nil
            self?.navigationItem.hidesBackButton = false
            self?.resultStoryLineScreenView.isHidden = true
            self?.resultStoryLineScreenView2.isHidden = true
            
            self?.showStoryLineCardGameView(currentLevel: 0)
        }
    }
    
    private func showAlert(title: String, message: String, isCancelAvailable: Bool = false, action: @escaping (() -> Void)) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // Добавляем кнопку "ОК"
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in
            action()
        }))
        
        if isCancelAvailable {
            // Добавляем кнопку "Отмена"
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        }
        
        // Отображаем алерт
        present(alert, animated: true, completion: nil)
    }
    
    private func showStoryLineCardGameView(currentLevel: Int) {
        var vm: StoryLineCardGameViewModelProtocol

        switch StoryLineHelper.shared.getStoryLineProgress() {
        case .storyLine1, .storyLine2, .storyLine3, .storyLine4, .storyLine5, .storyLineGame5:
            return
        case .storyLineGame1:
            vm = StoryLineCardGameViewModel()
        case .storyLineGame2:
            vm = StoryLineCardGameViewModel2()
        case .storyLineGame3:
            vm = StoryLineCardGameViewModel3()
        case .storyLineGame4:
            vm = StoryLineCardGameViewModel4()
        }
        
        storyLineCardGameView = StoryLineCardGameView(viewModel: vm.data[currentLevel])
        guard let storyLineCardGameView else { return }

        storyLineCardGameView.vc = self
        storyLineCardGameView.isFirst = (StoryLineHelper.shared.getStoryLineProgress() == .storyLineGame1) && (currentLevel == 0)
        storyLineCardGameView.setup()
        view.addSubview(storyLineCardGameView)
        storyLineCardGameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        showHelpButtons(isShow: true)
        
        storyLineCardGameView.finishedhandler = { [weak self] in
            guard let self else { return }
                    
            self.loadInterstitialAd()
            
            if currentLevel >= 2 {
                self.showHelpButtons(isShow: false)
                switch StoryLineHelper.shared.getStoryLineProgress() {
                case .storyLine1, .storyLine2, .storyLine3, .storyLine4, .storyLine5:
                    break
                case .storyLineGame1:
                    StoryLineHelper.shared.saveStoryLineProgress(.storyLine2)
                case .storyLineGame2:
                    StoryLineHelper.shared.saveStoryLineProgress(.storyLine3)
                case .storyLineGame3:
                    StoryLineHelper.shared.saveStoryLineProgress(.storyLine4)
                case .storyLineGame4:
                    StoryLineHelper.shared.saveStoryLineProgress(.storyLine5)
                case .storyLineGame5:
                    return
                }
                start()
            } else {
                self.showStoryLineCardGameView(currentLevel: currentLevel + 1)
            }
            storyLineCardGameView.removeFromSuperview()
        }
    }
    
    private func goToFinal(answerNumbwer: Int) {
        StoryLineHelper.shared.saveStoryLineProgress(.storyLineGame5)

        if answerNumbwer == 0 {
            FinalStoryLineHelper.shared.saveFinalStoryLineType(.workingWith)
            showFinalStoryLineView()
        } else {
            FinalStoryLineHelper.shared.saveFinalStoryLineType(.goodMan)
            if !RevardsHelper.shared.getFinishedRevards().contains(8) {
                RevardsHelper.shared.updateFinishedLevel(8)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title9".localized(),
                    subTitle: "RewardsScreen.SubTitle9".localized(),
                    image: UIImage(named: "trophy9")
                )
                
                storyLineScreenView.addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                
                // Запуск анимации
                trophyView.animateTrophyIn()
                trophyView.showFinalStoryLineViewHandler = { [weak self] in
                    self?.showFinalStoryLineView()
                }
                storyLineScreenView.bringSubviewToFront(trophyView)
            } else {
                showFinalStoryLineView()
            }
        }
    }
    
    private func showFinalStoryLineView() {
        view.addSubview(finalStoryLineView)
        finalStoryLineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        finalStoryLineView.setup()
        finalStoryLineView.restartButtonTappedHandler = { [weak self] in
            self?.showAlert(title: "FinalStoryLineView.Restart.Sure".localized(), message: "", isCancelAvailable: true, action: {
                FinalStoryLineHelper.shared.saveFinalResultType(.type1)
                FinalStoryLineHelper.shared.saveFinalStoryLineType(.goodMan)
                
                if !RevardsHelper.shared.getFinishedRevards().contains(8) {
                    RevardsHelper.shared.updateFinishedLevel(8)

                    let trophyView = TrophyView(frame: .zero)
                    trophyView.setup(
                        title: "RewardsScreen.Title9".localized(),
                        subTitle: "RewardsScreen.SubTitle9".localized(),
                        image: UIImage(named: "trophy9")
                    )
                    
                    self?.storyLineScreenView.addSubview(trophyView)
                    trophyView.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                        make.width.equalToSuperview().inset(20)
                        make.height.equalToSuperview().multipliedBy(0.5)
                    }
                    
                    // Запуск анимации
                    trophyView.animateTrophyIn()
                    self?.storyLineScreenView.bringSubviewToFront(trophyView)
                }

                StoryLineHelper.shared.saveCurrentquestionNumber(0)
                StoryLineHelper.shared.saveStoryLineProgress(.storyLine1)
                self?.navigationController?.popViewController(animated: true)
            })
        }
        
        finalStoryLineView.requestAppReviewHandler = { [weak self] in
            self?.requestAppReview()
        }
    }
    
    private func showHelpButtons(isShow: Bool) {
        if isShow {
            rulesButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
            rulesButton.tintColor = .white
            rulesButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
            
            revealCardsButton.setImage(UIImage(systemName: "eye"), for: .normal)
            revealCardsButton.tintColor = .white
            revealCardsButton.addTarget(self, action: #selector(revealCardsButtonTapped), for: .touchUpInside)
            
            skipLevelButton.setImage(UIImage(systemName: "chevron.right.2"), for: .normal)
            skipLevelButton.tintColor = .white
            skipLevelButton.addTarget(self, action: #selector(skipLevelButtonTapped), for: .touchUpInside)
            
            // Создаем UIStackView для размещения кнопок в центре навигейшен бара
            let buttonStackView = UIStackView(arrangedSubviews: [rulesButton, revealCardsButton, skipLevelButton])
            buttonStackView.axis = .horizontal
            buttonStackView.spacing = 20
            buttonStackView.alignment = .center
            buttonStackView.distribution = .equalSpacing
            
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
            
            // Устанавливаем StackView как titleView
            navigationItem.titleView = buttonStackView
        } else {
            navigationItem.titleView = nil
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
        showAlert(title: text, message: "", isCancelAvailable: true) { [weak self] in
            guard
                let self,
                let storyLineCardGameView = self.storyLineCardGameView,
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
        guard
            let storyLineCardGameView = self.storyLineCardGameView
        else {
            return
        }
        
        storyLineCardGameView.collectionView?.visibleCells.forEach { cell in
            guard
                let cell = cell as? CardCell,
                !cell.isMatch,
                !cell.isFliped
            else { return }
            
            storyLineCardGameView.isrevealed = true
            cell.flip()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                cell.flip()
                storyLineCardGameView.isrevealed = false
            }
        }
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
               storyLineCardGameView?.levelfinished()
               return
           }
           
           showAlert(title: "Cards.Skip".localized(), message: "", isCancelAvailable: true) { [weak self] in
               self?.showRewardedAdRevard()
           }
       }
}
