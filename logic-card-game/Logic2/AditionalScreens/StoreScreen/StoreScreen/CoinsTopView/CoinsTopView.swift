//
//  CoinsTopView.swift
//  Logic2
//
//  Created by Mikita on 23.09.24.
//

import UIKit
import SnapKit

class CoinView: UIView {
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MainCoin")
        return imageView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let gradientLayer = CAGradientLayer() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSpecialCoins), name: Notification.Name("saveSpecialCoins"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 25 // Закругление углов
        layer.shadowColor = UIColor.red.cgColor // Цвет тени
        layer.shadowOpacity = 0.9 // Прозрачность тени
        layer.shadowOffset = CGSize(width: 4, height: 4) // Смещение тени
        layer.shadowRadius = 6 // Радиус размытия тени
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        layer.masksToBounds = true
        
        // Настройка градиентного фона
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)

        addSubview(coinImageView)
        addSubview(amountLabel)

        // Установите ограничения для coinImageView
        coinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        // Установите ограничения для amountLabel
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(coinImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем рамки градиентного слоя
        gradientLayer.frame = bounds
    }
    
    func setAmount(_ amount: String) {
        if let amountInt = Int(amount) {
            amountLabel.text = "\(formatNumber(amountInt))"
        } else {
            amountLabel.text = amount
        }
    }
    
    @objc func updateSpecialCoins() {
        // Получаем текущие значения монет
        let specialCoins = CoinsHelper.shared.getSpecialCoins()
        
        if amountLabel.text != "\(formatNumber(specialCoins))" {
            amountLabel.text = "\(formatNumber(specialCoins))"
            // Анимация для specialLabel
            animateCoinLabel(label: amountLabel)
        }
    }
    
    private func animateCoinLabel(label: UILabel) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            // Увеличиваем масштаб
            label.transform = CGAffineTransform(scaleX: 3, y: 3)
            label.alpha = 0.3 // Полупрозрачный
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                // Возвращаем к исходному масштабу и прозрачности
                label.transform = .identity
                label.alpha = 1.0
            })
        })
    }
    
    private func formatNumber(_ number: Int) -> String {
        if number >= 1000 {
            let thousands = number / 1000
            return "\(thousands)k"
        } else {
            return "\(number)"
        }
    }
}
