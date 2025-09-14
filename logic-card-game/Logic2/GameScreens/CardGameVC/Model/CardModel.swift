//
//  CardModel.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit

struct Card {
    let id: Int
    let image: UIImage?
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

struct CardViewModel {
    let numberOfColumns: Int
    let numberOfRows: Int
    let backImage: UIImage?
    var data: [Card]
}

class CardModel {
    var currentCoplectionId: Int {
        return PurchasedLogicHelper.shared.getCoplectionBackId()
    }
    
    // словарь с комплектами картинок
    let images: [Int: [UIImage?]] = [
        1: [
            UIImage(named: "Robots21"),
            UIImage(named: "Robots211"),
            UIImage(named: "Robots22"),
            UIImage(named: "Robots212"),
            UIImage(named: "Robots23"),
            UIImage(named: "Robots31"),
            UIImage(named: "Robots24"),
            UIImage(named: "Robots32"),
            
            UIImage(named: "Robots25"),
            UIImage(named: "Robots33"),
            UIImage(named: "Robots26"),
            UIImage(named: "Robots34"),
            UIImage(named: "Robots29"),
            UIImage(named: "Robots35"),
            UIImage(named: "Robots210"),
            UIImage(named: "Robots36"),
            UIImage(named: "Robots11"),
            UIImage(named: "Robots214"),
            
            UIImage(named: "Robots12"),
            UIImage(named: "Robots17"),
            UIImage(named: "Robots13"),
            UIImage(named: "Robots18"),
            UIImage(named: "Robots14"),
            UIImage(named: "Robots19"),
            UIImage(named: "Robots15"),
            UIImage(named: "Robots16"),
            UIImage(named: "Robots111"),
            UIImage(named: "Robots112"),
            UIImage(named: "Robots37"),
            UIImage(named: "Robots113"),
            UIImage(named: "Robots114"),
            UIImage(named: "Robots115"),
            UIImage(named: "Robots116"),
            UIImage(named: "Robots27"),
            UIImage(named: "Robots28"),
        ],
        
        2: [
            UIImage(named: "Marv1"),
            UIImage(named: "Marv2"),
            UIImage(named: "Marv3"),
            UIImage(named: "Marv4"),
            UIImage(named: "Marv5"),
            UIImage(named: "Marv6"),
            UIImage(named: "Marv7"),
            UIImage(named: "Marv8"),
            
            UIImage(named: "Marv9"),
            UIImage(named: "Marv10"),
            UIImage(named: "Marv11"),
            UIImage(named: "Marv12"),
            UIImage(named: "Marv13"),
            UIImage(named: "Marv14"),
            UIImage(named: "Marv15"),
            UIImage(named: "Marv16"),
            UIImage(named: "Marv17"),
            UIImage(named: "Marv18"),
            
            UIImage(named: "Marv19"),
            UIImage(named: "Marv20"),
            UIImage(named: "Marv21"),
            UIImage(named: "Marv22"),
            UIImage(named: "Marv23"),
            UIImage(named: "Marv24"),
            UIImage(named: "Marv25"),
            UIImage(named: "Marv26"),
            UIImage(named: "Marv27"),
            UIImage(named: "Marv28"),
            UIImage(named: "Marv29"),
            UIImage(named: "Marv30"),
            UIImage(named: "Marv31"),
            UIImage(named: "Marv32"),
            UIImage(named: "Marv33"),
            UIImage(named: "Marv34"),
            UIImage(named: "Marv35"),
        ],
        
        3: [
            UIImage(named: "Witch1"),
            UIImage(named: "Witch2"),
            UIImage(named: "Witch3"),
            UIImage(named: "Witch4"),
            UIImage(named: "Witch5"),
            UIImage(named: "Witch6"),
            UIImage(named: "Witch7"),
            UIImage(named: "Witch8"),
            
            UIImage(named: "Witch9"),
            UIImage(named: "Witch10"),
            UIImage(named: "Witch11"),
            UIImage(named: "Witch12"),
            UIImage(named: "Witch13"),
            UIImage(named: "Witch14"),
            UIImage(named: "Witch15"),
            UIImage(named: "Witch16"),
            UIImage(named: "Witch17"),
            UIImage(named: "Witch18"),
            
            UIImage(named: "Witch19"),
            UIImage(named: "Witch20"),
            UIImage(named: "Witch21"),
            UIImage(named: "Witch22"),
            UIImage(named: "Witch23"),
            UIImage(named: "Witch24"),
            UIImage(named: "Witch25"),
            UIImage(named: "Witch26"),
            UIImage(named: "Witch1"),
            UIImage(named: "Witch2"),
            UIImage(named: "Witch3"),
            UIImage(named: "Witch4"),
            UIImage(named: "Witch5"),
            UIImage(named: "Witch6"),
            UIImage(named: "WitchMain"),
            UIImage(named: "Witch8"),
            UIImage(named: "Witch7"),
        ],
        
        4: [
            UIImage(named: "Cat1"),
            UIImage(named: "Cat2"),
            UIImage(named: "Cat3"),
            UIImage(named: "Cat4"),
            UIImage(named: "Cat5"),
            UIImage(named: "Cat6"),
            UIImage(named: "Cat7"),
            UIImage(named: "Cat8"),
            
            UIImage(named: "Cat9"),
            UIImage(named: "Cat10"),
            UIImage(named: "Cat11"),
            UIImage(named: "Cat12"),
            UIImage(named: "Cat13"),
            UIImage(named: "Cat14"),
            UIImage(named: "Cat15"),
            UIImage(named: "Cat16"),
            UIImage(named: "Cat17"),
            UIImage(named: "Cat18"),
            
            UIImage(named: "Cat19"),
            UIImage(named: "Cat20"),
            UIImage(named: "Cat21"),
            UIImage(named: "Cat22"),
            UIImage(named: "Cat23"),
            UIImage(named: "Cat24"),
            UIImage(named: "Cat25"),
            UIImage(named: "Cat26"),
            UIImage(named: "Cat27"),
            UIImage(named: "Cat28"),
            UIImage(named: "Cat29"),
            UIImage(named: "Cat30"),
            UIImage(named: "Cat31"),
            UIImage(named: "Cat32"),
            UIImage(named: "Cat33"),
            UIImage(named: "Cat34"),
            UIImage(named: "Cat35"),
        ],
        
        5: [
            UIImage(named: "Roc1"),
            UIImage(named: "Roc2"),
            UIImage(named: "Roc3"),
            UIImage(named: "Roc4"),
            UIImage(named: "Roc5"),
            UIImage(named: "Roc6"),
            UIImage(named: "Roc7"),
            UIImage(named: "Roc8"),
            
            UIImage(named: "Roc9"),
            UIImage(named: "Roc10"),
            UIImage(named: "Roc11"),
            UIImage(named: "Roc12"),
            UIImage(named: "Roc13"),
            UIImage(named: "Roc14"),
            UIImage(named: "Roc15"),
            UIImage(named: "Roc16"),
            UIImage(named: "Roc17"),
            UIImage(named: "Roc18"),
            
            UIImage(named: "Roc19"),
            UIImage(named: "Roc20"),
            UIImage(named: "Roc21"),
            UIImage(named: "Roc22"),
            UIImage(named: "Roc23"),
            UIImage(named: "Roc24"),
            UIImage(named: "Roc25"),
            UIImage(named: "Roc26"),
            UIImage(named: "Roc27"),
            UIImage(named: "Roc28"),
            UIImage(named: "Roc29"),
            UIImage(named: "Roc18"),
            UIImage(named: "Roc1"),
            UIImage(named: "Roc2"),
            UIImage(named: "Roc3"),
            UIImage(named: "Roc4"),
            UIImage(named: "Roc5"),
        ],
        
        6: [
            UIImage(named: "harry1"),
            UIImage(named: "harry2"),
            UIImage(named: "harry3"),
            UIImage(named: "harry4"),
            UIImage(named: "harry5"),
            UIImage(named: "harry6"),
            UIImage(named: "harry7"),
            UIImage(named: "harry8"),
            
            UIImage(named: "harry1"),
            UIImage(named: "harry2"),
            UIImage(named: "harry3"),
            UIImage(named: "harry4"),
            UIImage(named: "harry5"),
            UIImage(named: "harry6"),
            UIImage(named: "harry7"),
            UIImage(named: "harry8"),
            UIImage(named: "harry9"),
            UIImage(named: "harry10"),
            
            UIImage(named: "harry1"),
            UIImage(named: "harry2"),
            UIImage(named: "harry3"),
            UIImage(named: "harry4"),
            UIImage(named: "harry5"),
            UIImage(named: "harry6"),
            UIImage(named: "harry7"),
            UIImage(named: "harry8"),
            UIImage(named: "harry9"),
            UIImage(named: "harry10"),
            UIImage(named: "harry11"),
            UIImage(named: "harry12"),
            UIImage(named: "harry13"),
            UIImage(named: "harry14"),
            UIImage(named: "harry15"),
            UIImage(named: "harry16"),
            UIImage(named: "harry17")
        ],
        
        7: [
            UIImage(named: "flower1"),
            UIImage(named: "flower2"),
            UIImage(named: "flower3"),
            UIImage(named: "flower4"),
            UIImage(named: "flower5"),
            UIImage(named: "flower6"),
            UIImage(named: "flower7"),
            UIImage(named: "flower8"),
            
            UIImage(named: "flower1"),
            UIImage(named: "flower2"),
            UIImage(named: "flower3"),
            UIImage(named: "flower4"),
            UIImage(named: "flower5"),
            UIImage(named: "flower6"),
            UIImage(named: "flower7"),
            UIImage(named: "flower8"),
            UIImage(named: "flower9"),
            UIImage(named: "flower10"),
            
            UIImage(named: "flower1"),
            UIImage(named: "flower2"),
            UIImage(named: "flower3"),
            UIImage(named: "flower4"),
            UIImage(named: "flower5"),
            UIImage(named: "flower6"),
            UIImage(named: "flower7"),
            UIImage(named: "flower8"),
            UIImage(named: "flower9"),
            UIImage(named: "flower10"),
            UIImage(named: "flower11"),
            UIImage(named: "flower12"),
            UIImage(named: "flower13"),
            UIImage(named: "flower14"),
            UIImage(named: "flower15"),
            UIImage(named: "flower16"),
            UIImage(named: "flower17")
        ],
        
        8: [
            UIImage(named: "girl1"),
            UIImage(named: "girl2"),
            UIImage(named: "girl3"),
            UIImage(named: "girl4"),
            UIImage(named: "girl5"),
            UIImage(named: "girl6"),
            UIImage(named: "girl7"),
            UIImage(named: "girl8"),
            
            UIImage(named: "girl1"),
            UIImage(named: "girl2"),
            UIImage(named: "girl3"),
            UIImage(named: "girl4"),
            UIImage(named: "girl5"),
            UIImage(named: "girl6"),
            UIImage(named: "girl7"),
            UIImage(named: "girl8"),
            UIImage(named: "girl9"),
            UIImage(named: "girl10"),
            
            UIImage(named: "girl1"),
            UIImage(named: "girl2"),
            UIImage(named: "girl3"),
            UIImage(named: "girl4"),
            UIImage(named: "girl5"),
            UIImage(named: "girl6"),
            UIImage(named: "girl7"),
            UIImage(named: "girl8"),
            UIImage(named: "girl9"),
            UIImage(named: "girl10"),
            UIImage(named: "girl11"),
            UIImage(named: "girl12"),
            UIImage(named: "girl13"),
            UIImage(named: "girl14"),
            UIImage(named: "girl15"),
            UIImage(named: "girl16"),
            UIImage(named: "girl17")
        ],
    ]
    
    private lazy var cardDta16: [Card] = [
        Card(id: 1, image: images[currentCoplectionId]?[0]),
        Card(id: 1, image: images[currentCoplectionId]?[0]),
        Card(id: 2, image: images[currentCoplectionId]?[1]),
        Card(id: 2, image: images[currentCoplectionId]?[1]),
        Card(id: 3, image: images[currentCoplectionId]?[2]),
        Card(id: 3, image: images[currentCoplectionId]?[2]),
        Card(id: 4, image: images[currentCoplectionId]?[3]),
        Card(id: 4, image: images[currentCoplectionId]?[3]),
        Card(id: 5, image: images[currentCoplectionId]?[4]),
        Card(id: 5, image: images[currentCoplectionId]?[4]),
        Card(id: 6, image: images[currentCoplectionId]?[5]),
        Card(id: 6, image: images[currentCoplectionId]?[5]),
        Card(id: 7, image: images[currentCoplectionId]?[6]),
        Card(id: 7, image: images[currentCoplectionId]?[6]),
        Card(id: 8, image: images[currentCoplectionId]?[7]),
        Card(id: 8, image: images[currentCoplectionId]?[7])
    ]
    
    private lazy var cardDta20: [Card] = [
        Card(id: 1, image: images[currentCoplectionId]?[8]),
        Card(id: 1, image: images[currentCoplectionId]?[8]),
        Card(id: 2, image: images[currentCoplectionId]?[9]),
        Card(id: 2, image: images[currentCoplectionId]?[9]),
        Card(id: 3, image: images[currentCoplectionId]?[10]),
        Card(id: 3, image: images[currentCoplectionId]?[10]),
        Card(id: 4, image: images[currentCoplectionId]?[11]),
        Card(id: 4, image: images[currentCoplectionId]?[11]),
        Card(id: 5, image: images[currentCoplectionId]?[12]),
        Card(id: 5, image: images[currentCoplectionId]?[12]),
        Card(id: 6, image: images[currentCoplectionId]?[13]),
        Card(id: 6, image: images[currentCoplectionId]?[13]),
        Card(id: 7, image: images[currentCoplectionId]?[14]),
        Card(id: 7, image: images[currentCoplectionId]?[14]),
        Card(id: 8, image: images[currentCoplectionId]?[15]),
        Card(id: 8, image: images[currentCoplectionId]?[15]),
        Card(id: 9, image: images[currentCoplectionId]?[16]),
        Card(id: 9, image: images[currentCoplectionId]?[16]),
        Card(id: 10, image: images[currentCoplectionId]?[17]),
        Card(id: 10, image: images[currentCoplectionId]?[17]),
    ]
    
    private lazy var cardDta30: [Card] = [
        Card(id: 1, image: images[currentCoplectionId]?[19]),
        Card(id: 1, image: images[currentCoplectionId]?[19]),
        Card(id: 2, image: images[currentCoplectionId]?[20]),
        Card(id: 2, image: images[currentCoplectionId]?[20]),
        Card(id: 3, image: images[currentCoplectionId]?[21]),
        Card(id: 3, image: images[currentCoplectionId]?[21]),
        Card(id: 4, image: images[currentCoplectionId]?[22]),
        Card(id: 4, image: images[currentCoplectionId]?[22]),
        Card(id: 5, image: images[currentCoplectionId]?[23]),
        Card(id: 5, image: images[currentCoplectionId]?[23]),
        Card(id: 6, image: images[currentCoplectionId]?[24]),
        Card(id: 6, image: images[currentCoplectionId]?[24]),
        Card(id: 7, image: images[currentCoplectionId]?[25]),
        Card(id: 7, image: images[currentCoplectionId]?[25]),
        Card(id: 8, image: images[currentCoplectionId]?[26]),
        Card(id: 8, image: images[currentCoplectionId]?[26]),
        Card(id: 9, image: images[currentCoplectionId]?[27]),
        Card(id: 9, image: images[currentCoplectionId]?[27]),
        Card(id: 10, image: images[currentCoplectionId]?[28]),
        Card(id: 10, image: images[currentCoplectionId]?[28]),
        Card(id: 11, image: images[currentCoplectionId]?[29]),
        Card(id: 11, image: images[currentCoplectionId]?[29]),
        Card(id: 12, image: images[currentCoplectionId]?[30]),
        Card(id: 12, image: images[currentCoplectionId]?[30]),
        Card(id: 13, image: images[currentCoplectionId]?[31]),
        Card(id: 13, image: images[currentCoplectionId]?[31]),
        Card(id: 14, image: images[currentCoplectionId]?[32]),
        Card(id: 14, image: images[currentCoplectionId]?[32]),
        Card(id: 15, image: images[currentCoplectionId]?[33]),
        Card(id: 15, image: images[currentCoplectionId]?[33]),
    ]
    
    private let cardDta16nil: [Card] = [
        Card(id: 1, image: nil),
        Card(id: 1, image: nil),
        Card(id: 2, image: nil),
        Card(id: 2, image: nil),
        Card(id: 3, image: nil),
        Card(id: 3, image: nil),
        Card(id: 4, image: nil),
        Card(id: 4, image: nil),
        Card(id: 5, image: nil),
        Card(id: 5, image: nil),
        Card(id: 6, image: nil),
        Card(id: 6, image: nil),
        Card(id: 7, image: nil),
        Card(id: 7, image: nil),
        Card(id: 8, image: nil),
        Card(id: 8, image: nil)
    ]
    
    private let cardDta20nil: [Card] = [
        Card(id: 1, image: nil),
        Card(id: 1, image: nil),
        Card(id: 2, image: nil),
        Card(id: 2, image: nil),
        Card(id: 3, image: nil),
        Card(id: 3, image: nil),
        Card(id: 4, image: nil),
        Card(id: 4, image: nil),
        Card(id: 5, image: nil),
        Card(id: 5, image: nil),
        Card(id: 6, image: nil),
        Card(id: 6, image: nil),
        Card(id: 7, image: nil),
        Card(id: 7, image: nil),
        Card(id: 8, image: nil),
        Card(id: 8, image: nil),
        Card(id: 9, image: nil),
        Card(id: 9, image: nil),
        Card(id: 10, image: nil),
        Card(id: 10, image: nil),
    ]
    
    private let cardDta30nil: [Card] = [
        Card(id: 1, image: nil),
        Card(id: 1, image: nil),
        Card(id: 2, image: nil),
        Card(id: 2, image: nil),
        Card(id: 3, image: nil),
        Card(id: 3, image: nil),
        Card(id: 4, image: nil),
        Card(id: 4, image: nil),
        Card(id: 5, image: nil),
        Card(id: 5, image: nil),
        Card(id: 6, image: nil),
        Card(id: 6, image: nil),
        Card(id: 7, image: nil),
        Card(id: 7, image: nil),
        Card(id: 8, image: nil),
        Card(id: 8, image: nil),
        Card(id: 9, image: nil),
        Card(id: 9, image: nil),
        Card(id: 10, image: nil),
        Card(id: 10, image: nil),
        Card(id: 11, image: nil),
        Card(id: 11, image: nil),
        Card(id: 12, image: nil),
        Card(id: 12, image: nil),
        Card(id: 13, image: nil),
        Card(id: 13, image: nil),
        Card(id: 14, image: nil),
        Card(id: 14, image: nil),
        Card(id: 15, image: nil),
        Card(id: 15, image: nil),
    ]
    
    var currentCardsBackId: Int {
        return PurchasedLogicHelper.shared.getCurrentCardsBackId()
    }
    
    var currentBackImage: UIImage? {
        let card = StoreScreenViewModel().backCardsData.oneBackCardsModel.first {
            return $0.id == currentCardsBackId
        }
        return card?.image ?? UIImage(named: "CardImageBack13")
    }
    
    lazy var data: [CardViewModel] = [
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: currentBackImage,
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta16nil
        ),
        
        //
        
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: currentBackImage,
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta20nil
        ),
        //
        
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack14"),
            data: cardDta30nil
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: currentBackImage,
            data: cardDta30
        ),
        
    ]
}
