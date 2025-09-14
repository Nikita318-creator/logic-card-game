//
//  StoryLineCardGameViewModel4.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import UIKit

class StoryLineCardGameViewModel4: StoryLineCardGameViewModelProtocol {
    private let cardDta16: [Card] = [
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
    
    private let cardDta20: [Card] = [
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
    ]
    
    private let cardDta30: [Card] = [
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
    
    lazy var data: [CardViewModel] = [
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 5,
            backImage: UIImage(named: "CardImageBack7"),
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack7"),
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 5,
            numberOfRows: 6,
            backImage: UIImage(named: "CardImageBack7"),
            data: cardDta30
        ),
      
    ]
}
