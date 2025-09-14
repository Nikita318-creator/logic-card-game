//
//  StoryLineCardGameViewModel.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import UIKit

protocol StoryLineCardGameViewModelProtocol {
    var data: [CardViewModel] { get }
}

class StoryLineCardGameViewModel: StoryLineCardGameViewModelProtocol {
    private let cardDta16: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots11")),
        Card(id: 1, image: UIImage(named: "Robots11")),
        Card(id: 2, image: UIImage(named: "Robots12")),
        Card(id: 2, image: UIImage(named: "Robots12")),
        Card(id: 3, image: UIImage(named: "Robots13")),
        Card(id: 3, image: UIImage(named: "Robots13")),
        Card(id: 4, image: UIImage(named: "Robots14")),
        Card(id: 4, image: UIImage(named: "Robots14")),
    ]
    
    private let cardDta20: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots15")),
        Card(id: 1, image: UIImage(named: "Robots15")),
        Card(id: 2, image: UIImage(named: "Robots16")),
        Card(id: 2, image: UIImage(named: "Robots16")),
        Card(id: 3, image: UIImage(named: "Robots17")),
        Card(id: 3, image: UIImage(named: "Robots17")),
        Card(id: 4, image: UIImage(named: "Robots18")),
        Card(id: 4, image: UIImage(named: "Robots18")),
        Card(id: 5, image: UIImage(named: "Robots19")),
        Card(id: 5, image: UIImage(named: "Robots19")),
        Card(id: 6, image: UIImage(named: "Robots110")),
        Card(id: 6, image: UIImage(named: "Robots110")),
    ]
    
    private let cardDta30: [Card] = [
        Card(id: 1, image: UIImage(named: "Robots111")),
        Card(id: 1, image: UIImage(named: "Robots111")),
        Card(id: 2, image: UIImage(named: "Robots112")),
        Card(id: 2, image: UIImage(named: "Robots112")),
        Card(id: 3, image: UIImage(named: "Robots113")),
        Card(id: 3, image: UIImage(named: "Robots113")),
        Card(id: 4, image: UIImage(named: "Robots114")),
        Card(id: 4, image: UIImage(named: "Robots114")),
        Card(id: 5, image: UIImage(named: "Robots115")),
        Card(id: 5, image: UIImage(named: "Robots115")),
        Card(id: 6, image: UIImage(named: "Robots116")),
        Card(id: 6, image: UIImage(named: "Robots116")),
    ]
    
    lazy var data: [CardViewModel] = [
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 2,
            backImage: UIImage(named: "CardImageBack4"),
            data: cardDta16
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 3,
            backImage: UIImage(named: "CardImageBack4"),
            data: cardDta20
        ),
        CardViewModel(
            numberOfColumns: 4,
            numberOfRows: 3,
            backImage: UIImage(named: "CardImageBack4"),
            data: cardDta30
        ),
      
    ]
}

