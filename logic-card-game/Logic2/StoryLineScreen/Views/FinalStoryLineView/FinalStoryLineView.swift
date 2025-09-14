//
//  FinalStoryLineView.swift
//  Logic2
//
//  Created by никита уваров on 16.09.24.
//

import UIKit
import SnapKit

class FinalStoryLineView: UIView {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let restartButton = UIButton()

    private let storyLineScreenView = StoryLineScreenView(frame: .zero)
    private let resultStoryLineScreenView = ResultStoryLineScreenView(frame: .zero)
    
    private let viewModel = StoryLineScreen6ViewModel()

    var restartButtonTappedHandler: (() -> Void)?
    var requestAppReviewHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if FinalStoryLineHelper.shared.getFinalStoryLineType() != .workingWith {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = UIScreen.main.bounds
            gradientLayer.colors = [UIColor.purple.cgColor, UIColor.systemPurple.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func setup() {
        switch FinalStoryLineHelper.shared.getFinalStoryLineType() {
            
        case .goodMan, .workingWithFinished:
            requestAppReviewHandler?()

            storyLineScreenView.removeFromSuperview()
            resultStoryLineScreenView.removeFromSuperview()
            
            let resultext: String
            switch FinalStoryLineHelper.shared.getFinalResultType() {
            case .type1:
                resultext = "FinalStoryLineView.type1".localized()
            case .type2:
                resultext = "FinalStoryLineView.type2".localized()
            }

            setDescription(text: resultext)
            setupUI()
            
            if !RevardsHelper.shared.getFinishedRevards().contains(4) {
                RevardsHelper.shared.updateFinishedLevel(4)

                let trophyView = TrophyView(frame: .zero)
                trophyView.setup(
                    title: "RewardsScreen.Title5".localized(),
                    subTitle: "RewardsScreen.SubTitle5".localized(),
                    image: UIImage(named: "trophy5")
                )
                
                addSubview(trophyView)
                trophyView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview().inset(20)
                    make.height.equalToSuperview().multipliedBy(0.5)
                }
                // Запуск анимации
                trophyView.animateTrophyIn()
                bringSubviewToFront(trophyView)
            }
        case .workingWith:
            setupFinalQuest()
            setupFinalresulChat()
            resultStoryLineScreenView.isHidden = true            
        }
    }
    
    private func setupUI() {
        // Создаем контейнер с внутренними отступами
        let paddingView = UIView()
        addSubview(paddingView)
        paddingView.addSubview(descriptionLabel)
        
        // Настройка descriptionLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.simpleFont.withSize(18)
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.adjustsFontSizeToFitWidth = true // Включает автоматическое уменьшение шрифта
        descriptionLabel.minimumScaleFactor = 0.5 // Минимальный размер шрифта
        
        paddingView.layer.borderColor = UIColor.white.cgColor
        paddingView.layer.borderWidth = 6
        paddingView.layer.cornerRadius = 20
        paddingView.clipsToBounds = true
        paddingView.backgroundColor = .black.withAlphaComponent(0.2)
        
        // Создаем заголовок
        titleLabel.text = "FinalStoryLineView.Finished".localized() // Замените на нужный текст
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldFont.withSize(24)
        titleLabel.numberOfLines = 0
        
        // Создаем кнопку рестарта
        restartButton.setTitle("FinalStoryLineView.Restart".localized(), for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.titleLabel?.font = UIFont.cursiveFont.withSize(20)
        let underlineAttriString = NSMutableAttributedString(string: "FinalStoryLineView.Restart".localized())
        underlineAttriString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: underlineAttriString.length))
        restartButton.setAttributedTitle(underlineAttriString, for: .normal)
        restartButton.backgroundColor = .clear
        restartButton.addTarget(self, action: #selector(restartButtonTouchDown), for: .touchDown)
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: [.touchUpInside, .touchUpOutside])
        
        addSubview(titleLabel)
        addSubview(restartButton)
        addSubview(paddingView)
        
        // Установка ограничений для элементов
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        paddingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20) // Расстояние от кнопки
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(restartButton.snp.top).offset(-5) // Расстояние от кнопки
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        }
        
        restartButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-70)
            make.centerX.equalToSuperview()
        }
    }

    @objc private func restartButtonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.restartButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func restartButtonTapped() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.restartButton.transform = CGAffineTransform.identity
        } completion: { _ in
            self.restartButtonTappedHandler?()
        }
    }
    
    private func setDescription(text: String) {
        descriptionLabel.text = text
    }
    
    private func setupFinalQuest() {
        
        addSubview(storyLineScreenView)
        storyLineScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        StoryLineHelper.shared.saveCurrentquestionNumber(0)
        
        let data = viewModel.data1[StoryLineHelper.shared.getCurrentquestionNumber()]
        storyLineScreenView.configure(question: data.question, answer1: data.answer1, answer2: data.answer2, image: data.image)
        storyLineScreenView.setupUI()
        
        storyLineScreenView.answerSelectedHandler = { [weak self] answerNumbwer in
            self?.neeDecidenextQuestion(answerNumbwer: answerNumbwer)
        }
    }
    
    private func neeDecidenextQuestion(answerNumbwer: Int) {
        if StoryLineHelper.shared.getCurrentquestionNumber() >= 1 {
            FinalStoryLineHelper.shared.saveFinalStoryLineType(.workingWithFinished)
            storyLineScreenView.removeFromSuperview()
            resultStoryLineScreenView.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.setup()
            }
            
            return
        }
        
        StoryLineHelper.shared.saveCurrentquestionNumber(StoryLineHelper.shared.getCurrentquestionNumber() + 1)

        let data = answerNumbwer == 0 ? viewModel.data1[StoryLineHelper.shared.getCurrentquestionNumber()] : viewModel.data2[StoryLineHelper.shared.getCurrentquestionNumber()]
        storyLineScreenView.configure(question: data.question, answer1: data.answer1, answer2: data.answer2, isFirstQuestion: false, image: data.image)
    }
    
    private func setupFinalresulChat() {
        addSubview(resultStoryLineScreenView)
        resultStoryLineScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        resultStoryLineScreenView.configure(
            firstMessages: viewModel.firstMessages,
            secondMessages: viewModel.secondMessages
        )
    }
}

