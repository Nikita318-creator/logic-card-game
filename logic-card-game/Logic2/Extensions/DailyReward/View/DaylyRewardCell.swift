//
//  DaylyRewardCell.swift
//  Logic2
//
//  Created by Mikita on 24.09.24.
//


import UIKit
import SnapKit

class DaylyRewardCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let cardBackView = UIImageView()
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldFont.withSize(26) // Настройка шрифта
        label.textColor = .white // Цвет текста
        label.textAlignment = .center
        return label
    }()
    
    var isFliped: Bool {
        return !self.imageView.isHidden
    }

    var price: DaylyRewardPrice = .oneCoin
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.addSubview(cardBackView)
//        imageView.contentMode = .scaleAspectFill
        cardBackView.frame = contentView.bounds
        cardBackView.contentMode = .scaleToFill
        
        // Настройка внешнего вида ячейки
        setupCellAppearance()
        setupGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellAppearance() {
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 4.0 // Рамка
        contentView.layer.borderColor = UIColor.white.cgColor // Цвет рамки
        contentView.layer.cornerRadius = 20.0 // Радиус скругления
        contentView.layer.shadowColor = UIColor.red.cgColor // Цвет тени
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4) // Смещение тени
        
        // Добавляем лейбл и imageView в contentView
        contentView.addSubview(label)
        contentView.addSubview(imageView)

        // Настраиваем constraints
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(6)
        }

//        imageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(6)
//            make.centerX.equalToSuperview().inset(6)
//            make.width.height.equalToSuperview().inset(25)
//        }
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cardBackView.bounds
        gradientLayer.colors = [
            UIColor(red: 239/255, green: 222/255, blue: 185/255, alpha: 0.3).cgColor, // Бежевый цвет
            UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 0.3).cgColor  // Светло-серый цвет
        ]
        gradientLayer.locations = [0.0, 1.0]
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Добавляем маску с серыми пятнами
//        let patternImage = createPatternImage()
//        let patternLayer = CALayer()
//        patternLayer.frame = cardBackView.bounds
//        patternLayer.contents = patternImage.cgImage
//        patternLayer.opacity = 0.15 // Прозрачность пятен
//        contentView.layer.addSublayer(patternLayer)
    }

    private func createPatternImage() -> UIImage {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        // Заливка фона
        UIColor.clear.setFill()
        context.fill(CGRect(origin: .zero, size: size))
        
        // Рисуем серые круги
        UIColor.gray.setFill()
        for _ in 0..<4 {
            let circleSize = CGFloat.random(in: 8..<20) // Размер кругов
            let circleX = CGFloat.random(in: 0..<size.width - circleSize)
            let circleY = CGFloat.random(in: 0..<size.height - circleSize)
            let circlePath = UIBezierPath(ovalIn: CGRect(x: circleX, y: circleY, width: circleSize, height: circleSize))
            
            context.addPath(circlePath.cgPath)
            context.fillPath()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    func configure(with card: RewardCard, backImage: UIImage?, price: DaylyRewardPrice) {
        self.price = price
        imageView.backgroundColor = .clear
        cardBackView.image = backImage
        imageView.image = card.image
        label.text = "\(card.count)"
        label.isHidden = true
        imageView.isHidden = true
        cardBackView.isHidden = false
        
        switch price {
        case .skipLevel, .revilCards:
            imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(6)
                make.centerX.equalToSuperview().inset(6)
                make.width.equalToSuperview().inset(25)
                make.height.equalToSuperview().multipliedBy(0.6)
            }
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white
        case .oneCoin, .tenCoin:
            imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(6)
                make.centerX.equalToSuperview().inset(6)
                make.width.height.equalToSuperview().inset(25)
            }
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    func flip() {
        // Анимация переворота карточки
        UIView.transition(with: contentView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.imageView.isHidden = !self.imageView.isHidden
            self.label.isHidden = false
            self.cardBackView.isHidden = !self.cardBackView.isHidden
        }, completion: nil)
    }
}
