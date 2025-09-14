//
//  ViewController.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private enum Const {
        static let UserAgreementTitle = "UserAgreement".localized()
        static let StoreTitle = "Store".localized()
        static let RulesTitle = "Revards".localized()
        static let LevelsTitle = "Levels".localized()
        static let gameButtonTitle = "GameButtonTitle".localized()
    }

    private let mainButton = MainButton(title: Const.gameButtonTitle)
    private let levelsButton = MainButton(title: Const.LevelsTitle)
    private let revardsButton = MainButton(title: Const.RulesTitle)
    private let storeButton = MainButton(title: Const.StoreTitle)
    private let agreementButton = MainButton(title: Const.UserAgreementTitle)
 
    private let coinView = CoinView(frame: .zero)
    private let languageSelectionView = LanguageSelectionView(frame: .zero)
    private let dailyRewardView = DailyRewardView(frame: .zero)

    var isInAppEvent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - delete restart
//        FinalStoryLineHelper.shared.saveFinalResultType(.type1)
//        FinalStoryLineHelper.shared.saveFinalStoryLineType(.goodMan)
//        StoryLineHelper.shared.saveCurrentquestionNumber(0)
//        StoryLineHelper.shared.saveStoryLineProgress(.storyLine5)
//        CoinsHelper.shared.saveSpecialCoins(10000)
//        CoinsHelper.shared.saveRevil(CoinsHelper.shared.getRevil() + 3)
//        CoinsHelper.shared.saveSkips(CoinsHelper.shared.getSkips() + 10)

        // Создание UIImageView для фона
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "BackGraunds5")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.backgroundColor = .clear
        view.layoutIfNeeded()
        
        setupButtons()
        startBubbleAnimation()

        //  проинитить магазинные хелперы чтоб был выбран первый товар из списка
        if !PurchasedLogicHelper.shared.getIsFirstLounch() {
            PurchasedLogicHelper.shared.saveIsFirstLounch(true)
            PurchasedLogicHelper.shared.saveCoplectionBackId(1)
            PurchasedLogicHelper.shared.saveCurrentCardsBackId(1)
            CoinsHelper.shared.saveRevil(1)
            CoinsHelper.shared.saveSkips(1)
            
            // MARK: - IN APP EVENT:
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: -5 * 3600) // UTC-5
//            let targetDate = dateFormatter.date(from: "2025/02/18 23:30")!
//
//            if Date() < targetDate {
//
//            }
            
        } else {
            if CoinsHelper.shared.dailyReward() {
                view.addSubview(dailyRewardView)
                dailyRewardView.snp.makeConstraints { make in
                    make.centerY.equalToSuperview().inset(30)
                    make.height.equalToSuperview().multipliedBy(0.7)
                    make.leading.trailing.equalToSuperview().inset(10)
                }
            }
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        languageSelectionView.setLanguage()
        mainButton.setTitle("GameButtonTitle".localized(), for: .normal)
        levelsButton.setTitle("Levels".localized(), for: .normal)
        storeButton.setTitle("Store".localized(), for: .normal)
        revardsButton.setTitle("Revards".localized(), for: .normal)
        agreementButton.setTitle("UserAgreement".localized(), for: .normal)
        
        if isInAppEvent {
            inAppEventRevard()
            isInAppEvent = false
        }
    }
    
    private func setupButtons() {
        coinView.setAmount("\(CoinsHelper.shared.getSpecialCoins())")
        view.addSubview(coinView)
        coinView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(16) // Отступ от верхней части экрана
            make.trailing.equalToSuperview().inset(16) // Отступы по бокам
            make.height.equalTo(50) // Высота вьюшки
        }
        
        view.addSubview(languageSelectionView)
        languageSelectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(16) // Отступ от верхней части экрана
            make.leading.equalToSuperview().inset(16) // Отступы по бокам
            make.width.equalTo(50)
            make.height.equalTo(50) // Высота вьюшки
        }
        languageSelectionView.languageTappedHandler = { [weak self] in
            let languageSelectionViewController = LanguageSelectionViewController()
            self?.navigationController?.pushViewController(languageSelectionViewController, animated: false)
        }
        
        // MARK: - Настройка главной кнопки
        mainButton.setTitle(Const.gameButtonTitle, for: .normal)
        mainButton.addTarget(self, action: #selector(mainButtonTouchDown), for: .touchDown)
        mainButton.addTarget(self, action: #selector(navigateToNextScreen), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(mainButton)

        mainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(coinView.snp.bottom).inset(-20)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(70)
        }
        
        // MARK: - Настройка кнопки Levels
        levelsButton.setTitle(Const.LevelsTitle, for: .normal)
        levelsButton.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        levelsButton.addTarget(self, action: #selector(navigateToLevelsScreen), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(levelsButton)

        levelsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainButton.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(70)
        }

        // MARK: - Настройка кнопки Store
        storeButton.setTitle(Const.StoreTitle, for: .normal)
        storeButton.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        storeButton.addTarget(self, action: #selector(navigateToStoreScreen), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(storeButton)

        storeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(levelsButton.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(70)
        }
    
        // MARK: - Настройка кнопки Rules
        revardsButton.setTitle(Const.RulesTitle, for: .normal)
        revardsButton.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        revardsButton.addTarget(self, action: #selector(navigateToRewardsScreenVC), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(revardsButton)

        revardsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(storeButton.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(70)
        }
        
        // MARK: - Настройка кнопки User Agreement
        agreementButton.setTitle(Const.UserAgreementTitle, for: .normal)
        agreementButton.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        agreementButton.addTarget(self, action: #selector(navigateToAgreementScreen), for: [.touchUpInside, .touchUpOutside])
        view.addSubview(agreementButton)

        agreementButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(revardsButton.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(70)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc func mainButtonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.mainButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    // Универсальные методы для анимации нажатий
    @objc func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }

    // Навигация
    @objc func navigateToNextScreen() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.mainButton.transform = CGAffineTransform.identity
        } completion: { _ in
            if !StoryLineHelper.shared.getIsOnbordingFinished() {
                StoryLineHelper.shared.saveIsOnbordingFinished(true)
                let OnbordingView = OnbordingView(frame: .zero)
                OnbordingView.setup()
                OnbordingView.goToMainScreenHandler = {
                    let storyLineScreenVC = StoryLineScreenVC()
                    self.navigationController?.pushViewController(storyLineScreenVC, animated: false)
                }
                self.view.addSubview(OnbordingView)
                OnbordingView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            } else {
                let storyLineScreenVC = StoryLineScreenVC()
                self.navigationController?.pushViewController(storyLineScreenVC, animated: false)
            }
        }
    }

    @objc func navigateToLevelsScreen() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.levelsButton.transform = CGAffineTransform.identity
        } completion: { _ in
            let cardLevelsScrenVC = CardLevelsScrenVC()
            self.navigationController?.pushViewController(cardLevelsScrenVC, animated: false)
        }
    }

    @objc func navigateToStoreScreen() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.storeButton.transform = CGAffineTransform.identity
        } completion: { _ in
            let storeScreenVC = StoreScreenVC()
            self.navigationController?.pushViewController(storeScreenVC, animated: false)
        }
    }

    @objc func navigateToRewardsScreenVC() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.revardsButton.transform = CGAffineTransform.identity
        } completion: { _ in
            let rewardsScreenVC = RewardsScreenVC()
            self.navigationController?.pushViewController(rewardsScreenVC, animated: false)
        }
    }

    @objc func navigateToAgreementScreen() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.agreementButton.transform = CGAffineTransform.identity
        } completion: { _ in
            let agreementScreenVC = AgreementScreenVC()
            self.navigationController?.pushViewController(agreementScreenVC, animated: false)
        }
    }
    
    @objc private func startBubbleAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitterLayer.emitterShape = .circle
        emitterLayer.emitterSize = CGSize(width: view.bounds.width - 40, height: view.bounds.height) // Уменьшить размер эмиттера
        emitterLayer.emitterMode = .outline

        let cell = CAEmitterCell()
         cell.birthRate = 1
        cell.lifetime = 10
         cell.velocity = 20
         cell.velocityRange = 10
        cell.emissionLatitude = 2 * CGFloat.pi
//        cell.emissionLongitude = 2 * CGFloat.pi
         cell.spinRange = 5
         cell.scale = 0.5
         cell.scaleRange = 0.25
         cell.alphaSpeed = -0.025
        emitterLayer.emitterCells = [cell]

        // Изменение цвета пузырьков
        if let originalImage = UIImage(systemName: "circle.fill") {
            let ciImage = CIImage(image: originalImage)
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setValue(ciImage, forKey: kCIInputImageKey)
            colorFilter.setValue(CIColor(red: 0, green: 1, blue: 1, alpha: 0.5), forKey: "inputColor0") // Голубой полупрозрачный цвет
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 1, alpha: 0.5), forKey: "inputColor1") // Другой оттенок синего
            
            guard let outputImage = colorFilter.outputImage else { return }
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                cell.contents = cgImage // Используем созданный CGImage
            }
        }
        
        emitterLayer.emitterCells = [cell]
        self.view.layer.addSublayer(emitterLayer)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
////            emitterLayer.removeFromSuperlayer() // Удалить анимацию через 1 секунду
//        }
    }
}
