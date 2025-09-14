//
//  StoreScreenVC.swift
//  Baraban
//
//  Created by никита уваров on 25.08.24.
//

import UIKit
import SnapKit

enum PriceConst {
    static let blockAddsCost = 10000
}

class StoreScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private enum Const {
        static let bacgraundImagename = "mainIcon2"
    }
    
    private var collectionView: UICollectionView!
    private let coinView = CoinView(frame: .zero)

    let viewModel = StoreScreenViewModel()
    
    var isNeedScrollToCards: Bool = false
    var isInAppEvent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupCollectionView()
        registerCells()
        
        coinView.setAmount("\(CoinsHelper.shared.getSpecialCoins())")
        view.addSubview(coinView)
        coinView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)//.offset(16) // Отступ от верхней части экрана
            make.right.equalToSuperview().inset(16) // Отступы по бокам
            make.height.equalTo(50) // Высота вьюшки
        }
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
        if isNeedScrollToCards {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 3), at: .centeredVertically, animated: true)
        }
        
        if isInAppEvent {
            // TODO: - после ин апп евент выпилить этот код от крашей подальше
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .centeredVertically, animated: true)
                
                PurchasedLogicHelper.shared.addCardsBackPurchased(purchas: 9)
                PurchasedLogicHelper.shared.saveCurrentCardsBackId(9)
                NotificationCenter.default.post(name: Notification.Name("changeCurrentFont"), object: nil)
            }
        }
    }
    
    private func setupBackground() {
        // Создание UIImageView для фона
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: Const.bacgraundImagename)
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10 // Расстояние между ячейками
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) // Отступы для секций

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "StoreCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview() // Заполняет весь экран
            make.bottom.equalToSuperview().inset(70) // Заполняет весь экран
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }

    private func registerCells() {
        collectionView.register(BlockAddsCell.self, forCellWithReuseIdentifier: "BlockAddsCell")
        collectionView.register(BuyCoinsCell.self, forCellWithReuseIdentifier: "BuyCoinsCell")
        collectionView.register(CardsbackCell.self, forCellWithReuseIdentifier: "CardsbackCell")
        collectionView.register(CoplectsCell.self, forCellWithReuseIdentifier: "CoplectsCell")

        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
    }
    
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionModel = viewModel.data[section].section
        switch sectionModel {
        case .blockAdds, .buyCoins, .cardsBack, .coplects:
            return 1 // По одной ячейке в каждой из первых трех секций
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionModel = viewModel.data[indexPath.section].section

        switch sectionModel {
        case .blockAdds(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockAddsCell", for: indexPath) as? BlockAddsCell else {
                return UICollectionViewCell()
            }
            cell.viewController = self
            return cell

        case .buyCoins(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyCoinsCell", for: indexPath) as? BuyCoinsCell else {
                return UICollectionViewCell()
            }
            cell.viewModel = model
            cell.viewController = self
            return cell

        case .cardsBack(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsbackCell", for: indexPath) as? CardsbackCell else {
                return UICollectionViewCell()
            }
            cell.viewModel = model
            cell.viewController = self
            cell.scrollToTopHandler = {
                collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            return cell
            
        case .coplects(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoplectsCell", for: indexPath) as? CoplectsCell else {
                return UICollectionViewCell()
            }
            cell.viewModel = model
            cell.viewController = self
            cell.scrollToTopHandler = {
                collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
  
            // Установим текст для заголовка секции
            let sectionModel = viewModel.data[indexPath.section].section
            switch sectionModel {
            case .blockAdds:
                headerView.titleLabel.text = "StoreScreen.BlockAdds".localized()
            case .buyCoins:
                headerView.titleLabel.text = "StoreScreen.BuyCoins".localized()
            case .cardsBack(_):
                headerView.titleLabel.text = "StoreScreen.CardsBack.Title".localized()
            case .coplects(_):
                headerView.titleLabel.text = "StoreScreen.Coplex.Title".localized()
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionModel = viewModel.data[indexPath.section].section

        switch sectionModel {
        case .blockAdds(_):
            let width = collectionView.frame.width - 20 // Ширина ячейки с учетом отступов
            let height: CGFloat = 100 // Высота ячейки, можно задать по-другому
            return CGSize(width: width, height: height)

        case .buyCoins(_):
            let width = collectionView.frame.width - 20 // Ширина ячейки с учетом отступов
            let height: CGFloat = 2 * collectionView.frame.width / 3 + 50 // Высота ячейки, можно задать по-другому
            return CGSize(width: width, height: height)

        case .cardsBack(_):
            let width = collectionView.frame.width - 20 // Ширина ячейки с учетом отступов
            let height: CGFloat = 2 * collectionView.frame.width / 3 + 50 // Высота ячейки, можно задать по-другому
            return CGSize(width: width, height: height)
            
        case .coplects(_):
            let width = collectionView.frame.width - 20 // Ширина ячейки с учетом отступов
            let height: CGFloat = 2 * collectionView.frame.width / 3 + 50 // Высота ячейки, можно задать по-другому
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60) // Высота заголовка
    }
}
