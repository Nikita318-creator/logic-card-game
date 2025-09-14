//
//  CardCell.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit
import SnapKit

class CardCell: UICollectionViewCell {
    let chineseText = "爱和善智勇福德静喜信平昌友梦仁礼忠义慈荣光庆康宁乐诚贵幸善真愿"

    private let imageView = UIImageView()
    private let cardBackView = UIImageView()
    private let chineseLabel: UILabel = {
        let label = UILabel()
        label.text = "中" // Пример китайского иероглифа
        label.font = UIFont.systemFont(ofSize: 36) // Настройка шрифта
        label.textColor = .black // Цвет текста
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var isMatch = false
    var isFliped: Bool {
        return !self.imageView.isHidden
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(cardBackView)
        imageView.addSubview(chineseLabel) // Добавляем китайский лейбл на imageView
        imageView.contentMode = .scaleAspectFill
        
        backgroundColor = .clear
        
        imageView.frame = contentView.bounds
        cardBackView.frame = contentView.bounds
        cardBackView.isHidden = true
        cardBackView.contentMode = .scaleToFill
        
        // Настройка внешнего вида ячейки
        setupCellAppearance()
        
        // Настройка constraints для китайского лейбла
        chineseLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellAppearance() {
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4.0 // Рамка
        imageView.layer.borderColor = UIColor.white.cgColor // Цвет рамки
        imageView.layer.cornerRadius = 20.0 // Радиус скругления
        imageView.layer.shadowColor = UIColor.red.cgColor // Цвет тени
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4) // Смещение тени
        
        cardBackView.clipsToBounds = true
        cardBackView.layer.borderWidth = 4.0 // Рамка
        cardBackView.layer.borderColor = UIColor.white.cgColor // Цвет рамки
        cardBackView.layer.cornerRadius = 20.0 // Радиус скругления
        cardBackView.layer.shadowColor = UIColor.red.cgColor // Цвет тени
        cardBackView.layer.shadowOffset = CGSize(width: 4, height: 4) // Смещение тени
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [
            UIColor(red: 239/255, green: 222/255, blue: 185/255, alpha: 1.0).cgColor, // Бежевый цвет
            UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor  // Светло-серый цвет
        ]
        gradientLayer.locations = [0.0, 1.0]
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Добавляем маску с серыми пятнами
        let patternImage = createPatternImage()
        let patternLayer = CALayer()
        patternLayer.frame = imageView.bounds
        patternLayer.contents = patternImage.cgImage
        patternLayer.opacity = 0.15 // Прозрачность пятен
        imageView.layer.addSublayer(patternLayer)
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
    
    func configure(with card: Card, backImage: UIImage?) {
        guard !card.isMatched else {
            cardBackView.image = nil
            imageView.image = nil
            imageView.isHidden = true
            cardBackView.isHidden = true
            self.layer.borderWidth = 0 // Рамка
            self.layer.borderColor = UIColor.clear.cgColor // Цвет рамки
            chineseLabel.isHidden = true // Скрываем лейбл при совпадении
            return
        }
        
        if card.image == nil {
            // Настройка градиентного фона и пятен, если изображение отсутствует
            setupGradientBackground()
            chineseLabel.isHidden = false
            if chineseText.count > card.id {
                let index = chineseText.index(chineseText.startIndex, offsetBy: card.id)
                chineseLabel.text = String(chineseText[index])
            } else {
                chineseLabel.text = "中"
            }
        } else {
            imageView.backgroundColor = .clear // Убираем фон при наличии изображения
            chineseLabel.isHidden = true
        }
        
        cardBackView.image = backImage
        imageView.image = card.image
        imageView.isHidden = !card.isFlipped
        cardBackView.isHidden = card.isFlipped
    }
    
    func flip() {
        // Анимация переворота карточки
        UIView.transition(with: contentView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.imageView.isHidden = !self.imageView.isHidden
            self.cardBackView.isHidden = !self.cardBackView.isHidden
        }, completion: nil)
    }
    
    func matched() {
        isMatch = true
        
        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
            // Сначала уменьшаем размер карточки
            self.imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.imageView.alpha = 0.0 // Постепенно делаем карточку прозрачной
            self.layer.borderWidth = 0 // Рамка
            self.layer.borderColor = UIColor.clear.cgColor // Цвет рамки
        }, completion: { _ in
            // Дополнительные действия по завершению анимации
        })
    }
}
