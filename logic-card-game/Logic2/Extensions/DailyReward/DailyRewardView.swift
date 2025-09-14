//
//  DailyRewardView.swift
//  Logic2
//
//  Created by Mikita on 24.09.24.
//

import UIKit
import SnapKit

class DailyRewardView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "DailyRewardView.Title".localized()
        label.font = UIFont.boldFont.withSize(28)
        label.textAlignment = .center
        label.textColor = .white // Цвет текста заголовка
        label.numberOfLines = 0
        return label
    }()
    
    private let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .white // Цвет разделительной линии
        return line
    }()
    
    private let okButton: BubbleButton = {
        let button = BubbleButton(frame: .zero)
        button.setup(title: "OK".localized())
//        button.setTitle("ОК", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5) // Неактивный цвет кнопки
        button.isEnabled = false // Кнопка по умолчанию не доступна
        return button
    }()
    
    private var collectionView: UICollectionView!
    
    private let viewModel = DailyRewardViewModel()
    
    private var isFliped = false
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupGradientBackground()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Обновляем размер градиентного слоя, чтобы он занимал весь размер представления
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
        }
    }
    
    private func setupView() {
        layer.cornerRadius = 30
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 4
        
        addSubview(titleLabel)
        addSubview(separatorLine)
        addSubview(okButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16) // Отступ сверху
            make.leading.trailing.equalToSuperview() // Заполняет по горизонтали
        }

        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8) // Отступ под заголовком
            make.leading.trailing.equalToSuperview() // Заполняет по горизонтали
            make.height.equalTo(1) // Высота линии
        }
        
        // Настраиваем коллекцию
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        // Регистрация ячейки
        collectionView.register(DaylyRewardCell.self, forCellWithReuseIdentifier: "DaylyRewardCell")
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(16) // Отступ под разделительной линией
            make.leading.trailing.equalToSuperview().inset(16) // Заполняет по горизонтали
            make.bottom.equalTo(okButton.snp.top).offset(-16) // Отступ выше кнопки
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self

        // Добавляем кнопку ОК
        okButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16) // Отступ снизу
            make.centerX.equalToSuperview() // Центр по горизонтали
            make.width.equalToSuperview().multipliedBy(0.3) // Ширина кнопки
            make.height.equalTo(60) // Высота кнопки
        }
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        // Определяем цвета для градиента
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemTeal.cgColor
        ]
        
        // Устанавливаем направление градиента
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Начало в верхнем левом углу
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Конец в нижнем правом углу
        
        // Добавляем градиентный слой в качестве подслоя
        self.layer.insertSublayer(gradientLayer, at: 0)        
    }
    
    @objc private func okButtonTapped() {
        self.removeFromSuperview()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DailyRewardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.numberOfColumns * viewModel.data.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaylyRewardCell", for: indexPath) as! DaylyRewardCell
        let card = viewModel.data.data[indexPath.item]
        cell.configure(with: card, backImage: viewModel.data.backImage, price: card.price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3 // Например, 3 ячейки в строке
        return CGSize(width: width, height: 1.25 * width) // Ячейка квадратная
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isFliped else { return }
        isFliped = true
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DaylyRewardCell else { return }
        cell.flip()
        startBubbleAnimation()
        cell.contentView.layer.borderColor = UIColor.systemBlue.cgColor // Цвет рамки
        
        switch cell.price {
        case .skipLevel:
            CoinsHelper.shared.saveSkips(CoinsHelper.shared.getSkips() + 1)
        case .revilCards:
            CoinsHelper.shared.saveRevil(CoinsHelper.shared.getRevil() + 1)
        case .oneCoin:
            CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + 1)
        case .tenCoin:
            CoinsHelper.shared.saveSpecialCoins(CoinsHelper.shared.getSpecialCoins() + 10)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            collectionView.visibleCells.forEach {
                if ($0 as? DaylyRewardCell)?.isFliped != true {
                    ($0 as? DaylyRewardCell)?.flip()
                }
            }
            self.okButton.isEnabled = true // Сделать кнопку доступной
            self.okButton.backgroundColor = UIColor.systemBlue // Изменить цвет кнопки, чтобы показать, что она доступна
        }
    }
    
    @objc private func startBubbleAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterShape = .circle
        emitterLayer.emitterSize = CGSize(width: bounds.width - 40, height: bounds.height) // Уменьшить размер эмиттера
        emitterLayer.emitterMode = .outline
        
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 1.5
        cell.velocity = bounds.width / 2
        cell.velocityRange = 50
        cell.emissionLatitude = 2 * CGFloat.pi
        cell.spinRange = 5
        cell.scale = 0.5
        cell.scaleRange = 0.25
        cell.alphaSpeed = -0.025
        emitterLayer.emitterCells = [cell]
        
        // Изменение цвета пузырьков
        if let originalImage = UIImage(systemName: "star.fill") {
            let ciImage = CIImage(image: originalImage)
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setValue(ciImage, forKey: kCIInputImageKey)
            colorFilter.setValue(CIColor(red: 1, green: 0.5, blue: 0, alpha: 0.8), forKey: "inputColor0") // Оранжево-красный полупрозрачный цвет
            colorFilter.setValue(CIColor(red: 0.6, green: 0, blue: 0.8, alpha: 0.5), forKey: "inputColor1") // Мягкий пурпурный полупрозрачный цвет
            
            guard let outputImage = colorFilter.outputImage else { return }
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                cell.contents = cgImage
            }
        }
        
        emitterLayer.emitterCells = [cell]
        self.layer.addSublayer(emitterLayer)
    }
}
