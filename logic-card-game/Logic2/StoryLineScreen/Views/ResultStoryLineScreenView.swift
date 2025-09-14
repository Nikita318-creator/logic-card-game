//
//  ResultStoryLineScreenView.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit
import SnapKit

class ResultStoryLineScreenView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let messagesStackView = UIStackView()
    //test
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        // MARK: - костыльное решение чтоб скролл работал
        let bottomSpacer = UIView()
        contentView.addSubview(bottomSpacer)
        contentView.addSubview(messagesStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(50)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        messagesStackView.axis = .vertical
        messagesStackView.spacing = 10
        messagesStackView.alignment = .leading
        
        messagesStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(16)
            make.width.equalTo(contentView)
        }
        
        bottomSpacer.backgroundColor = .black.withAlphaComponent(0.1)
        bottomSpacer.snp.makeConstraints { make in
            make.top.equalTo(messagesStackView)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func configure(firstMessages: [String], secondMessages: [String]) {
        // Очистить старые сообщения
        messagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Индексы для перебора сообщений
        var firstIndex = 0
        var secondIndex = 0
        
        let maxCount = max(firstMessages.count, secondMessages.count)
        
        // Добавляем сообщения, чередуя их
        for _ in 0..<maxCount {
            if firstIndex < firstMessages.count {
                let message = firstMessages[firstIndex]
                let messageView = createMessageView(message: message, isIncoming: true)
                messagesStackView.addArrangedSubview(messageView) // Добавляем в stackView
                messageView.snp.remakeConstraints { make in
                    make.width.lessThanOrEqualToSuperview().multipliedBy(0.75)
                    make.height.greaterThanOrEqualTo(40)
                    make.trailing.greaterThanOrEqualToSuperview().offset(-20) // Отступ от левого края
                    make.leading.equalToSuperview()
                }
                firstIndex += 1
            }
            
            if secondIndex < secondMessages.count {
                let message = secondMessages[secondIndex]
                let messageView = createMessageView(message: message, isIncoming: false)
                messagesStackView.addArrangedSubview(messageView) // Добавляем в stackView
                messageView.snp.remakeConstraints { make in
                    make.width.lessThanOrEqualToSuperview().multipliedBy(0.75)
                    make.height.greaterThanOrEqualTo(40)
                    make.leading.greaterThanOrEqualToSuperview().offset(20) // Отступ от левого края
                    make.trailing.equalToSuperview().inset(20)
                }
                secondIndex += 1
            }
        }
    }
    
    private func createMessageView(message: String, isIncoming: Bool) -> UIView {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let messageLabel = UILabel()
            messageLabel.text = "\n " + " \(message) " + "\n"
            messageLabel.numberOfLines = 0
            messageLabel.backgroundColor = isIncoming ? .lightGray : .blue
            messageLabel.textColor = isIncoming ? .black : .white
            messageLabel.layer.cornerRadius = 15
            messageLabel.layer.masksToBounds = true
            messageLabel.font = UIFont.systemFont(ofSize: 28)
            messageLabel.textAlignment = .center
            
            let messageContainer = UIView()
            messageContainer.addSubview(messageLabel)

            messageLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
            
            return messageContainer
        }
        
        let messageLabel = UILabel()
        messageLabel.text = "\n " + " \(message) " + "\n"
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = isIncoming ? .lightGray : .blue
        messageLabel.textColor = isIncoming ? .black : .white
        messageLabel.layer.cornerRadius = 15
        messageLabel.layer.masksToBounds = true
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        
        let messageContainer = UIView()
        messageContainer.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10) // Устанавливаем отступы
        }
        
        return messageContainer
    }
}
