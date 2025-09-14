//
//  StoryLineScreenView.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit
import SnapKit

class StoryLineScreenView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    
    let imageView = UIImageView()
    let questionLabel = UILabel()
    
    // Лейблы ответов
    let firstAnswerLabel = UILabel()
    let secondAnswerLabel = UILabel()
    
    let nextButton = UIButton()

    // Чекеры для каждого ответа
    let firstAnswerChecker = CircleCheckButton()
    let secondAnswerChecker = CircleCheckButton()
    let firstAnswerImageChecker = CircleCheckButton()
    let secondAnswerImageChecker = CircleCheckButton()
    let firstAnswerImageView = UIImageView()
    let secondAnswerImageView = UIImageView()

    var answerSelectedHandler: ((Int) -> Void)?

    var currentAnswer = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
     
    func configure(question: String, answer1: String, answer2: String, isFirstQuestion: Bool = true, image: UIImage?) {
        imageView.image = image

        nextButton.isEnabled = false
        nextButton.backgroundColor = .systemGray
        firstAnswerChecker.isChecked = false
        secondAnswerChecker.isChecked = false
        firstAnswerImageChecker.isChecked = false
        secondAnswerImageChecker.isChecked = false
        
        questionLabel.text = question
        questionLabel.backgroundColor = .black.withAlphaComponent(0.7)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        if answer1.isEmpty && answer2.isEmpty {
            if isFirstQuestion {
                firstAnswerImageView.image = UIImage(named: "StoryLineScreenView41")
                secondAnswerImageView.image = UIImage(named: "StoryLineScreenView42")
            } else {
                firstAnswerImageView.image = UIImage(named: "StoryLineScreenView43")
                secondAnswerImageView.image = UIImage(named: "StoryLineScreenView44")
            }
            firstAnswerLabel.isHidden = true
            secondAnswerLabel.isHidden = true
            firstAnswerChecker.isHidden = true
            secondAnswerChecker.isHidden = true
            firstAnswerImageView.isHidden = false
            secondAnswerImageView.isHidden = false
            firstAnswerImageChecker.isHidden = false
            secondAnswerImageChecker.isHidden = false
            firstAnswerImageView.isUserInteractionEnabled = true
            secondAnswerImageView.isUserInteractionEnabled = true

            // Обновляем stackView
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            let firstAnswerImageStackView = UIStackView(arrangedSubviews: [firstAnswerImageChecker, firstAnswerImageView])
            firstAnswerImageStackView.axis = .horizontal
            firstAnswerImageStackView.spacing = 10
            firstAnswerImageStackView.alignment = .center

            let secondAnswerImageStackView = UIStackView(arrangedSubviews: [secondAnswerImageChecker, secondAnswerImageView])
            secondAnswerImageStackView.axis = .horizontal
            secondAnswerImageStackView.spacing = 10
            secondAnswerImageStackView.alignment = .center

            stackView.addArrangedSubview(firstAnswerImageStackView)
            stackView.addArrangedSubview(secondAnswerImageStackView)
        } else {
            firstAnswerLabel.isHidden = false
            secondAnswerLabel.isHidden = false
            firstAnswerChecker.isHidden = false
            secondAnswerChecker.isHidden = false
            firstAnswerImageView.isHidden = true
            secondAnswerImageView.isHidden = true
            firstAnswerImageChecker.isHidden = true
            secondAnswerImageChecker.isHidden = true
            
            configureAnswerLabel(label: firstAnswerLabel, text: answer1)
            configureAnswerLabel(label: secondAnswerLabel, text: answer2)
        }
    }
    
    func setupUI() {
        // Добавляем scrollView и contentView
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        // Добавляем contentView в scrollView
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // Устанавливаем ширину равной ширине scrollView
        }

        // MARK: - костыльное решение чтоб скролл работал
        let bottomSpacer = UIView()
        contentView.addSubview(bottomSpacer)

        // Настройка ImageView
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor

        // Настройка вопроса
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        if UIDevice.current.userInterfaceIdiom == .pad {
            questionLabel.font = UIFont.boldFont.withSize(36)
        } else {
            questionLabel.font = UIFont.boldFont.withSize(26)
        }
        
        questionLabel.textColor = UIColor(red: 222/255, green: 197/255, blue: 175/255, alpha: 1.0)
        questionLabel.layer.cornerRadius = 10
        questionLabel.clipsToBounds = true
        
        // Настройка stackView
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill

        // Добавление чекеров и лейблов в stackView
        let firstAnswerStackView = UIStackView(arrangedSubviews: [firstAnswerChecker, firstAnswerLabel])
        firstAnswerStackView.axis = .horizontal
        firstAnswerStackView.spacing = 10
        firstAnswerStackView.alignment = .center

        let secondAnswerStackView = UIStackView(arrangedSubviews: [secondAnswerChecker, secondAnswerLabel])
        secondAnswerStackView.axis = .horizontal
        secondAnswerStackView.spacing = 10
        secondAnswerStackView.alignment = .center

        stackView.addArrangedSubview(firstAnswerStackView)
        stackView.addArrangedSubview(secondAnswerStackView)

        // Добавление элементов на contentView
        contentView.addSubview(imageView)
        contentView.addSubview(questionLabel)
        contentView.addSubview(stackView)

        // Настройка кнопки "Далее"
        nextButton.setTitle("Next".localized(), for: .normal)
        nextButton.titleLabel?.font = UIFont.boldFont.withSize(20)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 25
        nextButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: [.touchUpInside, .touchUpOutside])
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = UIColor.white.cgColor

        contentView.addSubview(nextButton)
        
        // Настройка новых UIImageView
        firstAnswerImageView.contentMode = .scaleAspectFit
        firstAnswerImageView.image = UIImage(named: "StoryLineScreenView41")

        secondAnswerImageView.contentMode = .scaleAspectFit
        secondAnswerImageView.image = UIImage(named: "StoryLineScreenView42")

        // Размещение элементов с помощью SnapKit
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.height.equalTo(2 * UIScreen.main.bounds.width / 3)
        }

        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(10)
            make.trailing.equalTo(contentView).inset(20)
        }
        
        firstAnswerChecker.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        secondAnswerChecker.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        firstAnswerImageChecker.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        secondAnswerImageChecker.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        firstAnswerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width - 100)
        }
        
        secondAnswerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width - 100)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-60) // Устанавливаем нижний отступ для contentView
        }
        
        contentView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(scrollView)
        }

        bottomSpacer.backgroundColor = .black.withAlphaComponent(0.1)
        bottomSpacer.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.trailing.equalTo(contentView) // чтобы занять всю ширину
            make.bottom.equalTo(contentView.snp.bottom)//.inset(100) // прижать к нижней части
        }
        
        // Добавление жестов касания для лейблов
        let firstLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstAnswerTapped))
        let firstChekerTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstAnswerTapped))
        let firstImageChekerTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstAnswerTapped))
        let firstImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstAnswerTapped))
        firstAnswerLabel.addGestureRecognizer(firstLabelTapGesture)
        firstAnswerImageView.addGestureRecognizer(firstImageViewTapGesture)
        firstAnswerChecker.addGestureRecognizer(firstChekerTapGesture)
        firstAnswerImageChecker.addGestureRecognizer(firstImageChekerTapGesture)

        let secondLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondAnswerTapped))
        let secondChekerTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondAnswerTapped))
        let secondImageVieTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondAnswerTapped))
        let secondImageChekerTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondAnswerTapped))
        secondAnswerLabel.addGestureRecognizer(secondLabelTapGesture)
        secondAnswerImageView.addGestureRecognizer(secondImageVieTapGesture)
        secondAnswerChecker.addGestureRecognizer(secondChekerTapGesture)
        secondAnswerImageChecker.addGestureRecognizer(secondImageChekerTapGesture)
    }
    
    private func configureAnswerLabel(label: UILabel, text: String) {
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        
        label.isUserInteractionEnabled = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            label.font = UIFont.cursiveFont.withSize(32)
        } else {
            label.font = UIFont.cursiveFont.withSize(22)
        }
        label.contentMode = .center
    }
    
    // Обработка нажатий на первый вариант ответа
    @objc private func firstAnswerTapped() {
        // Ставим чек на первый вариант
        firstAnswerChecker.isChecked = true
        secondAnswerChecker.isChecked = false
        firstAnswerImageChecker.isChecked = true
        secondAnswerImageChecker.isChecked = false
        currentAnswer = 0
        nextButton.isEnabled = true
        nextButton.backgroundColor = .systemBlue
    }
    
    // Обработка нажатий на второй вариант ответа
    @objc private func secondAnswerTapped() {
        // Ставим чек на второй вариант
        firstAnswerChecker.isChecked = false
        secondAnswerChecker.isChecked = true
        firstAnswerImageChecker.isChecked = false
        secondAnswerImageChecker.isChecked = true
        currentAnswer = 1
        nextButton.isEnabled = true
        nextButton.backgroundColor = .systemBlue
    }
    
    @objc private func nextButtonTapped() {
        UIView.animate(withDuration: 0.1, delay: 0.2) {
            self.nextButton.transform = CGAffineTransform.identity
        } completion: { _ in
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.answerSelectedHandler?(self.currentAnswer)
        }
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.nextButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
}
