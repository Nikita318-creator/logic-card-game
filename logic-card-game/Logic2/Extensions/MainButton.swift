//
//  MainButton.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit

class MainButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(UIColor(white: 1.0, alpha: 0.9), for: .normal)
        titleLabel?.font = UIFont.cursiveFont.withSize(34)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        clipsToBounds = true
        layer.cornerRadius = 35
        
        // Устанавливаем закругленные углы для тени
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // Настройка градиентного слоя
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1.0).cgColor, // Лаванда
            UIColor(red: 186/255, green: 85/255, blue: 211/255, alpha: 1.0).cgColor, // Средний пурпурный
            UIColor(red: 128/255, green: 0/255, blue: 128/255, alpha: 1.0).cgColor, // Пурпурный
            UIColor(red: 148/255, green: 0/255, blue: 211/255, alpha: 1.0).cgColor, // Синий фиолетовый
            UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1.0).cgColor, // Индиго
            UIColor(red: 221/255, green: 160/255, blue: 221/255, alpha: 1.0).cgColor  // Светлый пурпурный
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 35 // Устанавливаем радиус градиента
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Настройка границы
        layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0).cgColor // Более серебряный цвет
        layer.borderWidth = 8 // Увеличиваем толщину рамки
        
        // Настройка тени
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем рамку градиентного слоя при изменении размеров кнопки
        layer.sublayers?.first?.frame = bounds
    }
}
