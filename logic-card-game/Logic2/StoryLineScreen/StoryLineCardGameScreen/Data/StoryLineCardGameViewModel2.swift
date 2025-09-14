//
//  StoryLineCardGameViewModel2.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import UIKit

class StoryLineCardGameViewModel2: StoryLineCardGameViewModelProtocol {
    private let cardDta16: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots21")),
        Card(id: 1, image: UIImage(named: "Robots21")),
        Card(id: 2, image: UIImage(named: "Robots22")),
        Card(id: 2, image: UIImage(named: "Robots22")),
        Card(id: 3, image: UIImage(named: "Robots23")),
        Card(id: 3, image: UIImage(named: "Robots23")),
        Card(id: 4, image: UIImage(named: "Robots24")),
        Card(id: 4, image: UIImage(named: "Robots24")),
        Card(id: 5, image: UIImage(named: "Robots25")),
        Card(id: 5, image: UIImage(named: "Robots25")),
        Card(id: 6, image: UIImage(named: "Robots26")),
        Card(id: 6, image: UIImage(named: "Robots26")),
        Card(id: 7, image: UIImage(named: "Robots27")),
        Card(id: 7, image: UIImage(named: "Robots27")),
        Card(id: 8, image: UIImage(named: "Robots28")),
        Card(id: 8, image: UIImage(named: "Robots28"))
    ]
    
    private let cardDta20: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots29")),
        Card(id: 1, image: UIImage(named: "Robots29")),
        Card(id: 2, image: UIImage(named: "Robots210")),
        Card(id: 2, image: UIImage(named: "Robots210")),
        Card(id: 3, image: UIImage(named: "Robots211")),
        Card(id: 3, image: UIImage(named: "Robots211")),
        Card(id: 4, image: UIImage(named: "Robots212")),
        Card(id: 4, image: UIImage(named: "Robots212")),
        Card(id: 5, image: UIImage(named: "Robots213")),
        Card(id: 5, image: UIImage(named: "Robots213")),
        Card(id: 6, image: UIImage(named: "Robots214")),
        Card(id: 6, image: UIImage(named: "Robots214")),
        Card(id: 7, image: UIImage(named: "Robots215")),
        Card(id: 7, image: UIImage(named: "Robots215")),
        Card(id: 8, image: UIImage(named: "Robots216")),
        Card(id: 8, image: UIImage(named: "Robots216")),
    ]
    
    private let cardDta30: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots217")),
        Card(id: 1, image: UIImage(named: "Robots217")),
        Card(id: 2, image: UIImage(named: "Robots218")),
        Card(id: 2, image: UIImage(named: "Robots218")),
        Card(id: 3, image: UIImage(named: "Robots219")),
        Card(id: 3, image: UIImage(named: "Robots219")),
        Card(id: 4, image: UIImage(named: "Robots220")),
        Card(id: 4, image: UIImage(named: "Robots220")),
        Card(id: 5, image: UIImage(named: "Robots221")),
        Card(id: 5, image: UIImage(named: "Robots221")),
        Card(id: 6, image: UIImage(named: "Robots222")),
        Card(id: 6, image: UIImage(named: "Robots222")),
        Card(id: 7, image: UIImage(named: "Robots223")),
        Card(id: 7, image: UIImage(named: "Robots223")),
        Card(id: 8, image: UIImage(named: "Robots224")),
        Card(id: 8, image: UIImage(named: "Robots224")),
        Card(id: 9, image: UIImage(named: "Robots225")),
        Card(id: 9, image: UIImage(named: "Robots225")),
        Card(id: 10, image: UIImage(named: "Robots226")),
        Card(id: 10, image: UIImage(named: "Robots226")),
    ]
    
    lazy var data: [CardViewModel] = [
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: UIImage(named: "CardImageBack5"),
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 4,
            backImage: UIImage(named: "CardImageBack5"),
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack5"),
            data: cardDta30
        ),
      
    ]
}
