//
//  CardsbackOneCell.swift
//  Baraban
//
//  Created by никита уваров on 7.09.24.
//

import UIKit
import SnapKit

class CardsbackOneCell: UICollectionViewCell {
  
    var text = ""
    
    // Создаем элементы интерфейса
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4.0 // Рамка
        imageView.layer.borderColor = UIColor.white.cgColor // Цвет рамки
        imageView.layer.cornerRadius = 20.0 // Радиус скругления
        imageView.layer.shadowColor = UIColor.red.cgColor // Цвет тени
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4) // Смещение тени
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.simpleFont.withSize(26)
        label.textColor = UIColor(red: 0.72, green: 0.53, blue: 0.04, alpha: 1.0)
        label.backgroundColor = .black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.layer.borderWidth = 4
        label.layer.borderColor = UIColor(red: 128/255, green: 0/255, blue: 32/255, alpha: 1.0).cgColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.borderWidth = 4
        layer.borderColor = UIColor(red: 128/255, green: 0/255, blue: 32/255, alpha: 1.0).cgColor
        
        // Добавляем элементы на ячейку
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        // Настраиваем констрейнты с использованием SnapKit
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
            make.bottom.equalToSuperview().offset(0) // Отступ от нижней границы ячейки
        }
    }
    
    func configure(cost: String, image: UIImage?) {
        text = cost
        imageView.image = image
        titleLabel.text = cost
    }
    
    func updateDidSelect(isSelect: Bool) {
        if isSelect {
            contentView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
            titleLabel.backgroundColor = .systemGreen.withAlphaComponent(0.5)
            titleLabel.text = "StoreScreen.Chosen".localized()
        } else {
            contentView.backgroundColor = .black.withAlphaComponent(0.8)
            titleLabel.backgroundColor = .black.withAlphaComponent(0.8)
            titleLabel.text = text
        }
    }
}
