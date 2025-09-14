//
//  RevardsScreenVC.swift
//  Logic2
//
//  Created by Mikita on 21.09.24.
//

import UIKit
import SnapKit

class RewardsScreenVC: UIViewController {
    
    // Массив изображений наград (вместо картинок использую placeholders)
    private let rewardTitles = [
        "RewardsScreen.Title1".localized(),
        "RewardsScreen.Title2".localized(),
        "RewardsScreen.Title3".localized(),
        "RewardsScreen.Title4".localized(),
        "RewardsScreen.Title5".localized(),
        "RewardsScreen.Title6".localized(),
        "RewardsScreen.Title7".localized(),
        "RewardsScreen.Title8".localized(),
        "RewardsScreen.Title9".localized()
    ]
    
    private let rewardDescriptions = [
        "RewardsScreen.SubTitle1".localized(),
        "RewardsScreen.SubTitle2".localized(),
        "RewardsScreen.SubTitle3".localized(),
        "RewardsScreen.SubTitle4".localized(),
        "RewardsScreen.SubTitle5".localized(),
        "RewardsScreen.SubTitle6".localized(),
        "RewardsScreen.SubTitle7".localized(),
        "RewardsScreen.SubTitle8".localized(),
        "RewardsScreen.SubTitle9".localized(),
    ]
    
    private let rewarTrophy = [
        "trophy1",
        "trophy2",
        "trophy3",
        "trophy4",
        "trophy5",
        "trophy6",
        "trophy7",
        "trophy8",
        "trophy9",
    ]
    
    // Контейнер для картинок наград
    private let rewardsContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        view.backgroundColor = .white
        title = "RewardsScreen.text".localized()

        setupRewardsGrid()
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 222/255, green: 184/255, blue: 135/255, alpha: 1).cgColor, // средний бежевый
            UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1).cgColor, // светлый бежевый
            UIColor(red: 210/255, green: 180/255, blue: 140/255, alpha: 1).cgColor  // темный бежевый
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupRewardsGrid() {
        let backView = UIView()
        view.addSubview(backView)
        backView.addSubview(rewardsContainer)
        backView.backgroundColor = .clear
        
        let rows = 3
        let cols = 3
        let padding: CGFloat = 20 // Увеличиваем отступ
        let imageSize = (UIScreen.main.bounds.width - 60) / CGFloat(cols) // Увеличиваем отступы для более комфортного размещения
        
        // Расположение контейнера с наградами
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rewardsContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(imageSize * 4.5 + 60)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        for i in 0..<rewardTitles.count {
            let row = i / rows
            let col = i % cols
            
            let rewardView = createRewardView(
                imageName: rewarTrophy[i],
                title: rewardTitles[i],
                description: rewardDescriptions[i],
                isFinished: RevardsHelper.shared.getFinishedRevards().contains(i)
            )
            rewardView.tag = i
            rewardView.isUserInteractionEnabled = true
            rewardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rewardTapped(_:))))
            rewardsContainer.addSubview(rewardView)
            
            rewardView.snp.makeConstraints { make in
                make.width.equalTo(imageSize)
                make.height.equalTo(imageSize * 1.5) // Сделаем контейнер выше, чтобы было место для текста
                make.top.equalToSuperview().offset(CGFloat(row) * (imageSize * 1.5 + padding))
                make.leading.equalToSuperview().offset(CGFloat(col) * (imageSize + padding))
            }
        }
    }

    private func createRewardView(imageName: String, title: String, description: String, isFinished: Bool) -> UIView {
        let rewardView = UIView()
        
        // Картинка награды (больше размера)
        let rewardImageView = UIImageView()
        rewardImageView.image = UIImage(named: isFinished ? imageName : imageName + " 1")
        rewardImageView.contentMode = .scaleAspectFit
        rewardImageView.tintColor = .systemGray
        rewardView.addSubview(rewardImageView)
        
        // Название награды
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14) // Чуть меньше шрифт
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        rewardView.addSubview(titleLabel)
        
        // Установка ограничений для изображения
        rewardImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(rewardView.snp.height).multipliedBy(0.55) // Высота изображения 55% от контейнера
        }
        
        // Установка ограничений для названия
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        return rewardView
    }

    @objc private func rewardTapped(_ sender: UITapGestureRecognizer) {
        guard let rewardView = sender.view else { return }
        let index = rewardView.tag
        let description = rewardDescriptions[index]
        
        let alert = UIAlertController(title: rewardTitles[index], message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
