//
//  StoreScreenViewModel.swift
//  Baraban
//
//  Created by никита уваров on 6.09.24.
//

import UIKit

struct BlockAddsModel {
    var text: String
}

struct OneCoinModel {
    var image: UIImage?
    var title: String // cost String
    var subtitle: String // coinCount string
    var cost: Double
    var coinCount: Int
    var productIdentifier: String
}

struct BuyCoinsModel {
    var oneCoinModel: [OneCoinModel]
}

struct OneBackCardsModel {
    var image: UIImage?
    var title: String // cost String
    var cost: Int
    var id: Int
}

struct BackCardsModel {
    var oneBackCardsModel: [OneBackCardsModel]
}

struct CoplectsOneCellModel {
    var image: UIImage?
    var title: String // cost String
    var cost: Int
    var id: Int
}

struct CoplectsCellModel {
    var coplectsOneCellModel: [CoplectsOneCellModel]
}

enum StoreSectionModel {
    case buyCoins(BuyCoinsModel)
    case cardsBack(BackCardsModel)
    case coplects(CoplectsCellModel)
    case blockAdds(BlockAddsModel)
}

struct StoreScreenModel {
    var section: StoreSectionModel
}

class StoreScreenViewModel {
    var data: [StoreScreenModel] = []
    
    // Пример заполнения модели данными
    let buyCoinsData: BuyCoinsModel = BuyCoinsModel(
        oneCoinModel: [
            OneCoinModel(
                image: UIImage(named: "Coins1"),
                title: "10",
                subtitle: "Purchases.Free".localized(),
                cost: 0,
                coinCount: 10,
                productIdentifier: ""
            ),
            OneCoinModel(
                image: UIImage(named: "Coins2"),
                title: "100",
                subtitle: "0.99 $",
                cost: 0.99,
                coinCount: 100,
                productIdentifier: ProductIDs.product100
            ),
            OneCoinModel(
                image: UIImage(named: "Coins3"),
                title: "500",
                subtitle: "1.99 $",
                cost: 1.99,
                coinCount: 500,
                productIdentifier: ProductIDs.product500
            ),
            OneCoinModel(
                image: UIImage(named: "Coins4"),
                title: "1 000",
                subtitle: "2.99 $",
                cost: 2.99,
                coinCount: 1000,
                productIdentifier: ProductIDs.product1000
            ),
            OneCoinModel(
                image: UIImage(named: "Coins5"),
                title: "10 000",
                subtitle: "4.99 $",
                cost: 4.99,
                coinCount: 10000,
                productIdentifier: ProductIDs.product10000
            ),
        ]
    )
    
    let backCardsData: BackCardsModel = BackCardsModel(
        oneBackCardsModel: [
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack13"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 0,
                id: 1
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack2"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 0,
                id: 2
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack3"),
                title: "10",
                cost: 10,
                id: 3
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack8"),
                title: "10",
                cost: 10,
                id: 4
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack9"),
                title: "20",
                cost: 20,
                id: 5
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack10"),
                title: "50",
                cost: 50,
                id: 6
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack11"),
                title: "100",
                cost: 100,
                id: 7
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack12"),
                title: "500",
                cost: 500,
                id: 8
            ),
            OneBackCardsModel(
                image: UIImage(named: "CardImageBack15"),
                title: "1 000",
                cost: 1000,
                id: 9
            ),
        ]
    )
    
    let coplectsData = CoplectsCellModel(
        coplectsOneCellModel: [
            CoplectsOneCellModel(
                image: UIImage(named: "Robots331"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 0,
                id: 1
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "MarvMain"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 0,
                id: 2
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "WitchMain"),
                title: "100",
                cost: 100,
                id: 3
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "Cat1"),
                title: "100",
                cost: 100,
                id: 4
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "Roc2"),
                title: "100",
                cost: 100,
                id: 5
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "harry1"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 100,
                id: 6
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "flower11"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 100,
                id: 7
            ),
            CoplectsOneCellModel(
                image: UIImage(named: "girl3"),
                title: "StoreScreen.Buy.Coins.Avaliable".localized(),
                cost: 100,
                id: 8
            ),
            
            
        ]
    )
    
    init() {
        
        data = [
            StoreScreenModel(section: .coplects(coplectsData)),
            StoreScreenModel(section: .cardsBack(backCardsData)),
            StoreScreenModel(section: .buyCoins(buyCoinsData)),
            StoreScreenModel(section: .blockAdds(BlockAddsModel(text: ""))),
        ]
    }
}
