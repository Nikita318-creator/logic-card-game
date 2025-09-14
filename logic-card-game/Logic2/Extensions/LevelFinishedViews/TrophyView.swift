//
//  TrophyView.swift
//  Logic2
//
//  Created by Mikita on 22.09.24.
//

import UIKit
import SnapKit
import AudioToolbox

class TrophyView: UIView {
    
    private let trophyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldFont.withSize(36)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.8, alpha: 1.0)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldFont.withSize(32)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        return button
    }()
    
    var showFinalStoryLineViewHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setup(title: String, subTitle: String, image: UIImage?) {
        trophyImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = subTitle
    }
    
    private func setupView() {
        // Создаем градиентный фон
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 0.0, green: 0.3, blue: 0.6, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Добавляем картинку, заголовок, описание и кнопку OK в стек
        let contentStackView = UIStackView(arrangedSubviews: [trophyImageView, titleLabel, descriptionLabel, okButton])
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.alignment = .center
        
        addSubview(contentStackView)
        
        // Устанавливаем ограничения
        contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Ограничения для кнопки
        okButton.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(60)
        }
        
        // Ограничения для картинки трофея
        trophyImageView.snp.makeConstraints { make in
            make.height.equalTo(150) // Размер картинки
            make.width.equalTo(150)
        }
        
        addBorder()
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
    
    func animateTrophyIn() {
        // Начальная позиция за пределами экрана
        self.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        // Анимация перемещения
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
            self.transform = .identity
        }, completion: nil)

        // Воспроизводим системный звук награды
        AudioServicesPlaySystemSound(1013) // Системный звук (например, звук трофея)
    }
    
    @objc private func okButtonTapped() {
        // Анимация скрытия
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        }) { _ in
            self.showFinalStoryLineViewHandler?()
            self.removeFromSuperview()
        }
    }
}
