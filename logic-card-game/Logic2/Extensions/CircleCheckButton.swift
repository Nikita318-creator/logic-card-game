//
//  CircleCheckButton.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit

class CircleCheckButton: UIButton {
    
    // Переменная для отслеживания состояния чекера
    var isChecked = false {
        didSet {
            updateAppearance()
        }
    }
    
    // Увеличенный радиус области нажатия
    var touchAreaPadding: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Настройка внешнего вида кнопки (круга)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .white.withAlphaComponent(0.1)
    }
    
    private func updateAppearance() {
        self.backgroundColor = isChecked ? .systemBlue : .white.withAlphaComponent(0.1)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // Расширяем область касания кнопки
        let largerBounds = self.bounds.insetBy(dx: -touchAreaPadding, dy: -touchAreaPadding)
        return largerBounds.contains(point)
    }
}

