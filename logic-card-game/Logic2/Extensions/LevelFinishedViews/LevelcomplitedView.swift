//
//  LevelcomplitedView.swift
//  Logic2
//
//  Created by никита уваров on 11.09.24.
//

import UIKit
import SnapKit

class LevelcomplitedView: UIView {
    
    var okDidTapHandler: (() -> Void)?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Levelcomplited.Title".localized()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldFont.withSize(36)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1.0) // Светлый синий цвет
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldFont.withSize(32)
        button.addTarget(self, action: #selector(okButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(okButtonTapped), for: [.touchUpInside, .touchUpOutside])
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        return button
    }()
    
    private let scoreView = ScoreView() // Initialize ScoreView
    
    func setup(time: TimeInterval, errors: Int, isStoryLine: Bool = false) {
        scoreView.isHidden = isStoryLine
        // Создание фона с градиентом
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0).cgColor,
                                        UIColor(red: 0.0, green: 0.3, blue: 0.6, alpha: 1.0).cgColor] // Custom gradient from dark to light blue
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Создаем stackView для заголовка и описания
        let contentStackView = UIStackView(arrangedSubviews: [titleLabel])
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.alignment = .center
        
        // Создаем stackView для всего контента
        let mainStackView = UIStackView(arrangedSubviews: [contentStackView, scoreView, okButton])
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.alignment = .center
        mainStackView.distribution = .equalSpacing
        
        addSubview(mainStackView)
        
        // Устанавливаем ограничения для основного stackView
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20) // Отступ сверху
            make.bottom.equalToSuperview().inset(20) // Отступ снизу
        }
        
        // Устанавливаем ограничения для кнопки
        okButton.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(60)
        }
        
        // Устанавливаем ограничения для ScoreView
        scoreView.snp.makeConstraints { make in
            make.width.equalToSuperview()//.multipliedBy(0.8) // Adjust width as needed
            make.height.equalTo(150) // Adjust height as needed
        }
        
        scoreView.setupLabels(
            time: time,
            errors: errors
        )
        
        // Добавление рамки и разделительных линий
        addBorder()
    }
    
    @objc private func okButtonTouchDown() {
          UIView.animate(withDuration: 0.1) {
              self.okButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
          }
      }
      
      @objc private func okButtonTapped() {
          UIView.animate(withDuration: 0.1, delay: 0) {
              self.okButton.transform = CGAffineTransform.identity
          } completion: { _ in
              self.okDidTapHandler?()
          }
      }
    
    private func addBorder() {
        // Рамка вокруг всей вью
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 6
        layer.cornerRadius = 30
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем кадр градиентного слоя при изменении размеров представления
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}
