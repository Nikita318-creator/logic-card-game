//
//  LanguageSelectionView.swift
//  Logic2
//
//  Created by Mikita on 27.09.24.
//

import UIKit
import SnapKit

class LanguageSelectionView: UIView {
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    var languageTappedHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLanguage()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(languageTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 10 // Закругление углов
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        layer.masksToBounds = true
        
        // Настройка градиентного фона
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
        
        addSubview(languageLabel)
        
        // Установите ограничения для languageLabel
        languageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем рамки градиентного слоя
        gradientLayer.frame = bounds
    }
    
    func setLanguage() {
        let currentLanguageCode = UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.current.languageCode ?? "en"
        languageLabel.text = currentLanguageCode.uppercased()
    }
    
    @objc private func languageTapped() {
        languageTappedHandler?()
    }
}

