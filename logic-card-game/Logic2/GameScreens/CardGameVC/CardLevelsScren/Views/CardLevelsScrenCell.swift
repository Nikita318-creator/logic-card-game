//
//  CardLevelsScrenCell.swift
//  Logic2
//
//  Created by никита уваров on 11.09.24.
//

import UIKit
import SnapKit

class CardLevelsScrenCell: UICollectionViewCell {
    
    // Лейбл для текста
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.simpleFont.withSize(28)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // Градиентный слой
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.5, green: 0, blue: 1, alpha: 0.8).cgColor, // Пурпурный
            UIColor(red: 0.2, green: 0, blue: 0.5, alpha: 0.8).cgColor  // Темно-пурпурный
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    private let starImageView = ExtraStarsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Настройка contentView
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = false // Убедитесь, что это false
        layer.masksToBounds = false
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        clipsToBounds = true
        contentView.clipsToBounds = true
        
        // Настройка тени для внешнего слоя
        layer.cornerRadius = 20
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 6, height: 6)
        layer.shadowRadius = 1
        
        // Добавляем градиентный слой
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Добавляем лейбл и иконку звезды на ячейку
        contentView.addSubview(titleLabel)
        contentView.addSubview(starImageView)
        
        // Настройка констрейнтов для лейбла
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        
        // Настройка констрейнтов для иконки звезды
        starImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).inset(5)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        layer.sublayers?.first?.frame = bounds
        
        // Обновляем углы
        contentView.layer.cornerRadius = 20
        layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func configure(text: String, isCurrentLevel: Bool, isFinished: Bool, currentLevelProgress: LevelProgresCard) {
        titleLabel.text = text
        
        var progressStarsCount = 0
        if currentLevelProgress.isFinished {
            progressStarsCount += 1
        }
        if currentLevelProgress.isTime {
            progressStarsCount += 1
        }
        if currentLevelProgress.isError {
            progressStarsCount += 1
        }
        starImageView.updateColor(progressStarsCount: progressStarsCount)
        
        // Настройка границы
        if isFinished {
            layer.borderColor = UIColor.yellow.withAlphaComponent(0.8).cgColor
        } else if isCurrentLevel {
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.borderColor = UIColor.systemGray.withAlphaComponent(0.8).cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.layer.shadowColor = UIColor.red.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
