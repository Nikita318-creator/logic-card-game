//
//  DailyRewardViewModel.swift
//  Logic2
//
//  Created by Mikita on 24.09.24.
//

import UIKit

enum DaylyRewardPrice: Decodable {
    case oneCoin
    case tenCoin
    case skipLevel
    case revilCards
}

struct RewardCard {
    let id: Int
    let image: UIImage?
    let count: Int
    let price: DaylyRewardPrice
}

struct RewardCardViewModel {
    let numberOfColumns: Int
    let numberOfRows: Int
    let backImage: UIImage?
    var data: [RewardCard]
}

class DailyRewardViewModel {
    private let RewardCardDta9: [RewardCard] = [
        RewardCard(id: 1, image: UIImage(named: "MainCoin"), count: 1, price: .oneCoin),
        RewardCard(id: 2, image: UIImage(systemName: "chevron.right.2"), count: 1, price: .skipLevel),
        RewardCard(id: 3, image: UIImage(named: "MainCoin"), count: 1, price: .oneCoin),
        RewardCard(id: 4, image: UIImage(systemName: "chevron.right.2"), count: 1, price: .skipLevel),
        RewardCard(id: 5, image: UIImage(named: "MainCoin"), count: 1, price: .oneCoin),
        RewardCard(id: 6, image: UIImage(systemName: "eye"), count: 1, price: .revilCards),
        RewardCard(id: 7, image: UIImage(named: "MainCoin"), count: 1, price: .oneCoin),
        RewardCard(id: 8, image: UIImage(systemName: "eye"), count: 1, price: .revilCards),
        RewardCard(id: 9, image: UIImage(named: "MainCoin"), count: 10, price: .tenCoin),
    ]
    
    lazy var data = RewardCardViewModel(
        numberOfColumns: 3,
        numberOfRows: 3,
        backImage: UIImage(named: "CardImageBack14"),
        data: RewardCardDta9.shuffled()
    )
}
