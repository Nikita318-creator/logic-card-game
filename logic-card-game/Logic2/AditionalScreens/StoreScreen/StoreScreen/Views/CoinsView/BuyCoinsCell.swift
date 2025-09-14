//
//  BuyCoinsCell.swift
//  Baraban
//
//  Created by никита уваров on 6.09.24.
//

import UIKit
import SnapKit
import GoogleMobileAds

class BuyCoinsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var stackView: UIStackView!
    
    var rewardedAd: GADRewardedAd?
    
    var viewModel: BuyCoinsModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var viewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupCollectionView()
        
        loadRewardedAd()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        // Создание UIStackView
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10) // Отступы для stackView
        }
    }
    
    private func setupCollectionView() {
        // Настройка компоновки
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Создание UICollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        // Регистрация ячейки
        collectionView.register(OneCoinCell.self, forCellWithReuseIdentifier: "OneCoinCell")
        
        // Добавляем collectionView в stackView
        stackView.addArrangedSubview(collectionView)
        
        // Устанавливаем высоту collectionView через ограничение
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Фиксированная высота для вложенной коллекции
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.oneCoinModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneCoinCell", for: indexPath) as? OneCoinCell,
            let data = viewModel?.oneCoinModel[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: data.image, title: data.title, subtitle: data.subtitle)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 2 * collectionView.frame.height / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let data = viewModel?.oneCoinModel[indexPath.item]
        else {
            return
        }
        
        buyTapped(data: data)
    }
    
    private func buyTapped(data: OneCoinModel) {
        // Создание и отображение алерта
        let title = data.cost == 0
            ? "StoreScreen.Buy.Coins.Adds1".localized() + " \(data.coinCount) " + "StoreScreen.Buy.Coins.Adds2".localized()
            : "StoreScreen.Buy.Coins".localized() + " \(data.coinCount) " + "StoreScreen.Buy.Coins.For".localized() + " \(data.cost) $"
        let message = data.cost == 0
            ? "StoreScreen.Buy.Coins.Adds.Message".localized()
            : "StoreScreen.Buy.Coins.Message".localized()
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "StoreScreen.BlockAddsCell.cancel".localized(),
            style: .cancel,
            handler: nil))
        
        alert.addAction(UIAlertAction(
            title:  "StoreScreen.BlockAddsCell.confirm".localized(),
            style: .destructive,
            handler: { [weak self] _ in
                if data.cost == 0 {
                    self?.showRewardedAd()
                } else {
//                    Запросите доступные продукты и начните покупку
                    InAppPurchaseManager.shared.requestProducts { [weak self] products in
                        if let product = products.first(where: { $0.productIdentifier == data.productIdentifier }) {
                            // Запустите покупку
                            InAppPurchaseManager.shared.purchase(product: product) { [weak self] result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .failed:
                                        self?.showResultAlert(title: "Purchases.InApp.failed.title".localized(), message: "Purchases.InApp.failed.message".localized())
                                    case .purchased:
                                        self?.showResultAlert(title: "Purchases.InApp.purchased.title".localized(), message: "Purchases.InApp.purchased.message".localized())
                                        CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + data.coinCount)
                                    case .restored:
                                        self?.showResultAlert(title: "Purchases.InApp.restored.title".localized(), message: "Purchases.InApp.restored.message".localized())
                                        CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + data.coinCount)
                                    }
                                }
                            }
                        } else {
                            // Обработка случая, когда продукт не найден
                            print("Product not found")
                            DispatchQueue.main.async {
                                self?.showResultAlert(title: "Purchases.InApp.failed.title".localized(), message: "Purchases.InApp.failed.message".localized())
                            }
                        }
                    }
//                    CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + data.coinCount)
                }
            }))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func showResultAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "StoreScreen.BlockAddsCell.cancel".localized(),
            style: .cancel,
            handler: nil))
        
        alert.addAction(UIAlertAction(
            title: "OK".localized(),
            style: .destructive,
            handler: { _ in

            }))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - GooglAdds

extension BuyCoinsCell: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad was dismissed")
//        loadRewardedAd() // Загрузите новое объявление после показа текущего
    }
    
    func loadRewardedAd() {
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
            
//            self?.showRewardedAd()
        }
    }

    func showRewardedAd() {
        if let rewardedAd = rewardedAd {
            rewardedAd.present(fromRootViewController: viewController) {
                // Это будет вызвано, когда пользователь получает вознаграждение
                let reward = rewardedAd.adReward
                print("User should receive \(reward.amount) \(reward.type)")
                self.giveRewardToUser()
            }
        } else {
            print("Rewarded ad wasn't ready")
            // Покажите другой экран или выполните альтернативное действие
            let alert = UIAlertController(
                title: "Sorry, ads are not available at the moment.",
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in

            }))
            CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + 1000)
            self.viewController?.present(alert, animated: true, completion: nil)
        }
        
        loadRewardedAd()
    }

    func giveRewardToUser() {
        // Логика для предоставления вознаграждения пользователю
        // Например, увеличьте количество монет
//        CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + data.coinCount)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + 10)
        }
    }
}
