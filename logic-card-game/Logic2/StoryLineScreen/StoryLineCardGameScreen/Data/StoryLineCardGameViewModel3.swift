//
//  StoryLineCardGameViewModel3.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//


import UIKit

class StoryLineCardGameViewModel3: StoryLineCardGameViewModelProtocol {
    
    private let cardDta16: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots31")),
        Card(id: 1, image: UIImage(named: "Robots31")),
        Card(id: 2, image: UIImage(named: "Robots32")),
        Card(id: 2, image: UIImage(named: "Robots32")),
        Card(id: 3, image: UIImage(named: "Robots33")),
        Card(id: 3, image: UIImage(named: "Robots33")),
        Card(id: 4, image: UIImage(named: "Robots34")),
        Card(id: 4, image: UIImage(named: "Robots34")),
        Card(id: 5, image: UIImage(named: "Robots35")),
        Card(id: 5, image: UIImage(named: "Robots35")),
        Card(id: 6, image: UIImage(named: "Robots36")),
        Card(id: 6, image: UIImage(named: "Robots36")),
        Card(id: 7, image: UIImage(named: "Robots37")),
        Card(id: 7, image: UIImage(named: "Robots37")),
        Card(id: 8, image: UIImage(named: "Robots38")),
        Card(id: 8, image: UIImage(named: "Robots38")),
        Card(id: 9, image: UIImage(named: "Robots39")),
        Card(id: 9, image: UIImage(named: "Robots39")),
        Card(id: 10, image: UIImage(named: "Robots310")),
        Card(id: 10, image: UIImage(named: "Robots310")),
    ]
    
    private let cardDta20: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots311")),
        Card(id: 1, image: UIImage(named: "Robots311")),
        Card(id: 2, image: UIImage(named: "Robots312")),
        Card(id: 2, image: UIImage(named: "Robots312")),
        Card(id: 3, image: UIImage(named: "Robots313")),
        Card(id: 3, image: UIImage(named: "Robots313")),
        Card(id: 4, image: UIImage(named: "Robots314")),
        Card(id: 4, image: UIImage(named: "Robots314")),
        Card(id: 5, image: UIImage(named: "Robots315")),
        Card(id: 5, image: UIImage(named: "Robots315")),
        Card(id: 6, image: UIImage(named: "Robots316")),
        Card(id: 6, image: UIImage(named: "Robots316")),
        Card(id: 7, image: UIImage(named: "Robots317")),
        Card(id: 7, image: UIImage(named: "Robots317")),
        Card(id: 8, image: UIImage(named: "Robots318")),
        Card(id: 8, image: UIImage(named: "Robots318")),
        Card(id: 9, image: UIImage(named: "Robots319")),
        Card(id: 9, image: UIImage(named: "Robots319")),
        Card(id: 10, image: UIImage(named: "Robots320")),
        Card(id: 10, image: UIImage(named: "Robots320")),
    ]
    
    private let cardDta30: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots321")),
        Card(id: 1, image: UIImage(named: "Robots321")),
        Card(id: 2, image: UIImage(named: "Robots322")),
        Card(id: 2, image: UIImage(named: "Robots322")),
        Card(id: 3, image: UIImage(named: "Robots323")),
        Card(id: 3, image: UIImage(named: "Robots323")),
        Card(id: 4, image: UIImage(named: "Robots324")),
        Card(id: 4, image: UIImage(named: "Robots324")),
        Card(id: 5, image: UIImage(named: "Robots325")),
        Card(id: 5, image: UIImage(named: "Robots325")),
        Card(id: 6, image: UIImage(named: "Robots326")),
        Card(id: 6, image: UIImage(named: "Robots326")),
        Card(id: 7, image: UIImage(named: "Robots327")),
        Card(id: 7, image: UIImage(named: "Robots327")),
        Card(id: 8, image: UIImage(named: "Robots328")),
        Card(id: 8, image: UIImage(named: "Robots328")),
        Card(id: 9, image: UIImage(named: "Robots329")),
        Card(id: 9, image: UIImage(named: "Robots329")),
        Card(id: 10, image: UIImage(named: "Robots330")),
        Card(id: 10, image: UIImage(named: "Robots330")),
        Card(id: 11, image: UIImage(named: "Robots331")),
        Card(id: 11, image: UIImage(named: "Robots331")),
        Card(id: 12, image: UIImage(named: "Robots332")),
        Card(id: 12, image: UIImage(named: "Robots332")),
    ]
    
    lazy var data: [CardViewModel] = [
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack6"),
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack6"),
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack6"),
            data: cardDta30
        ),
      
    ]
}

