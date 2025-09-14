//
//  StoryLineCardGameView.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//


import UIKit
import SnapKit
import AudioToolbox

class StoryLineCardGameView: UIView {
    private let correctSoundID: SystemSoundID = 1001  // Успешный звук
    private let finishedSoundID: SystemSoundID = 1013  // Успешный звук
    private let errorSoundID: SystemSoundID = 1053  // Ошибочный звук
    private var emitterLayer: CAEmitterLayer?

    private var cards: [Card] = []
    private let spacing: CGFloat = 10
    private(set) var collectionView: UICollectionView!
    private var timeLabel: UILabel!
    private var errorsLabel: UILabel!

    // game logic
    private var firstFlippedCardIndex: IndexPath?
    private var flipedCount = 0
    private var matchedCount = 0
    private var errorsCount: Int = 0
    var isrevealed = false
    private var timer: Timer?
    private var startTime: Date?
    
    var isFirst = false
    
    var vc: UIViewController?
    var finishedhandler: (() -> Void)?
    private var viewModel: CardViewModel
        
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showAlert(title: String, message: String, action: @escaping (() -> Void)) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in
            action()
        }))
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        guard let startTime = startTime else { return }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        let roundedElapsedTime = Int(round(elapsedTime))
        timeLabel.text = "  " + "Cards.Time".localized() + "\(roundedElapsedTime).0" + "   "
        
        timeLabel.textColor = elapsedTime < CardGameHelper.shared.maxSecondsCount ? .white : .red
    }
    
    private func getCurrentTime() -> TimeInterval? {
        guard let startTime = startTime else { return nil }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        return elapsedTime
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setup() {
        if isFirst {
            showAlert(title: "Cards.Rulls".localized(), message: "") {  }
        }
        errorsCount = 0
        startTimer()
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "mainIcon2")
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        layoutIfNeeded()

        setupLabels()
        setupCollection()
        setupCards()
    }
    
    private func setupLabels() {
        // Настройка timeLabel
        timeLabel = UILabel()
        timeLabel.text = "  " + "Cards.Time".localized() + "0.0" + "    "
        timeLabel.textAlignment = .center
        timeLabel.numberOfLines = 1
        timeLabel.font = UIFont.simpleFont.withSize(16)
        timeLabel.textColor = .white // Белый текст для лучшего контраста
        
        // Настройка фона
        timeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Полупрозрачный черный
        timeLabel.layer.cornerRadius = 10
        timeLabel.clipsToBounds = true
        
        addSubview(timeLabel)

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        
        // Настройка errorsLabel
        errorsLabel = UILabel()
        errorsLabel.text = "  " + "Cards.Errors".localized() + "\(errorsCount)" + "    "
        errorsLabel.textAlignment = .center
        errorsLabel.numberOfLines = 1
        errorsLabel.font = UIFont.simpleFont.withSize(16)
        errorsLabel.textColor = .white // Белый текст для лучшего контраста
        
        // Настройка фона
        errorsLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Полупрозрачный черный
        errorsLabel.layer.cornerRadius = 10
        errorsLabel.clipsToBounds = true
        
        
        addSubview(errorsLabel)

        errorsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupCollection() {
        // Создание UICollectionViewLayout
        let layout = UICollectionViewFlowLayout()
        
        // Расчет размеров ячеек
        let totalSpacing = spacing * CGFloat(viewModel.numberOfColumns - 1)
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - 20 - totalSpacing) / CGFloat(viewModel.numberOfColumns)
        let itemHeight: CGFloat = itemWidth + 20
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing // Промежутки между ячейками
        layout.minimumLineSpacing = spacing // Промежутки между строками

        // Создание UICollectionView с заданным layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        
        // Установка ограничений для UICollectionView
        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(rulesLabel.snp.bottom).offset(5)
//            make.centerX.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(itemHeight * CGFloat(viewModel.numberOfRows) + (spacing * CGFloat(viewModel.numberOfRows - 1)))
        }
    }

    private func setupCards() {
        cards = viewModel.data.shuffled().shuffled().shuffled()
//        cards = viewModel.data
    }
    
    func levelfinished() {
        let time = getCurrentTime() ?? 0
        stopTimer()
        
        let levelcomplitedView = LevelcomplitedView()
        levelcomplitedView.clipsToBounds = true
        levelcomplitedView.layer.cornerRadius = 20
        levelcomplitedView.alpha = 0 // Устанавливаем начальную прозрачность в 0
        levelcomplitedView.layer.borderColor = UIColor.black.cgColor
        levelcomplitedView.layer.borderWidth = 0.5
        
        levelcomplitedView.okDidTapHandler = { [weak self] in
            self?.finishedhandler?()
            self?.emitterLayer?.removeFromSuperlayer() // Удалить анимацию через 1 секунду
        }
                
        levelcomplitedView.setup(
            time: time,
            errors: errorsCount,
            isStoryLine: true
        )
       
        addSubview(levelcomplitedView)
        startBubbleAnimation()
        
        // Устанавливаем начальные размеры и позицию
        levelcomplitedView.snp.makeConstraints { make in
            make.center.equalToSuperview() // Центрируем по центру экрана
            make.width.height.equalTo(0)  // Начальная ширина и высота равны 0
        }
        
        // Анимация изменения размеров и прозрачности
        UIView.animate(withDuration: 0.5, animations: {
            levelcomplitedView.alpha = 1 // Делаем видимым
            levelcomplitedView.snp.remakeConstraints { make in
                make.center.equalToSuperview() // Центрируем по центру экрана
                make.width.equalTo(UIScreen.main.bounds.width - 30)
            }
            self.layoutIfNeeded() // Обновляем макет
        })
    }
}

extension StoryLineCardGameView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        let card = cards[indexPath.item]
        cell.configure(with: card, backImage: viewModel.backImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard flipedCount < 2, !isrevealed else { return }
        
        guard !cards[indexPath.item].isFlipped, !cards[indexPath.item].isMatched else { return }
        
        flipedCount += 1
        
        cards[indexPath.item].isFlipped = true
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        cell.flip()
        
        if let firstIndex = firstFlippedCardIndex {
            let firstCardIndex = firstIndex.item
            let secondCardIndex = indexPath.item
            
            let firstCard = cards[firstCardIndex]
            let secondCard = cards[secondCardIndex]
            
            if firstCard.id == secondCard.id {
                cards[firstCardIndex].isMatched = true
                cards[secondCardIndex].isMatched = true
                flipedCount = 0
                firstFlippedCardIndex = nil
                
                let firstCell = collectionView.cellForItem(at: firstIndex) as! CardCell
                firstCell.matched()
                cell.matched()
                matchedCount += 2
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    AudioServicesPlaySystemSound(self.correctSoundID)
                }
                
                if matchedCount >= cards.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        AudioServicesPlaySystemSound(self.finishedSoundID)
                        self.levelfinished()
                    }
                }
            } else {
                errorsCount += 1
                errorsLabel.text = "  " + "Cards.Errors".localized() + "\(errorsCount)" + "   "
                errorsLabel.textColor = errorsCount < CardGameHelper.shared.maxErrorCount ? .white : .red

                // Воспроизведение звука ошибки
                AudioServicesPlaySystemSound(errorSoundID)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.cards[firstCardIndex].isFlipped = false
                    self.cards[secondCardIndex].isFlipped = false
                    
                    collectionView.performBatchUpdates({
                        collectionView.reloadItems(at: [firstIndex, indexPath])
                    }) { [weak self] _ in
                        self?.flipedCount = 0
                    }
                }
                firstFlippedCardIndex = nil
            }
        } else {
            firstFlippedCardIndex = indexPath
        }
    }
    @objc private func startBubbleAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterShape = .circle
        emitterLayer.emitterSize = CGSize(width: 40, height: 80) // Уменьшить размер эмиттера
        emitterLayer.emitterMode = .outline
        
        let cell = CAEmitterCell()
        cell.birthRate = 3
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
        self.emitterLayer = emitterLayer
        self.layer.addSublayer(emitterLayer)
    }
}
