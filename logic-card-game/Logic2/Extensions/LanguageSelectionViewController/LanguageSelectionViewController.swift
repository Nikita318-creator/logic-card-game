//
//  LanguageSelectionViewController.swift
//  Logic2
//
//  Created by Mikita on 27.09.24.
//

import UIKit
import SnapKit

class LanguageSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let languages = [
        "English",
        "Русский",
        "Français",
        "Español",
        "Deutsch",       // Немецкий
        "Português",     // Португальский
        "Türkçe",        // Турецкий
        "Italiano",      // Итальянский
        "العربية",       // Арабский
        "中文",           // Китайский
        "Svenska",       // Шведский
        "हिन्दी",        // Индийский
        "Polski",        // Польский
        "日本語"          // Японский
    ]
    
    let languageCodes = [
        "en", "ru", "fr", "es", "de", "pt", "tr", "it", "ar", "zh-Hans", "sv", "hi", "pl", "ja"
    ]
    
    let languagePicker = UIPickerView()
    let label = UILabel()
    let alertButton = UIButton(type: .system) // Создаем кнопку
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание UIImageView для фона
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "mainIcon1")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        view.layoutIfNeeded()
        
        setupLanguagePicker()
        setupAlertButton() // Настраиваем кнопку
        
        label.text = "LanguageSelectionView.Text".localized()
        label.textColor = .black
        label.backgroundColor = .white.withAlphaComponent(0.7)
        label.numberOfLines = 0
        label.font = UIFont.boldFont.withSize(28)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        scrollToCurrentLanguage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Проверяем, является ли текущий контроллер в навигационном стеке
        if self.isMovingFromParent {
            // Здесь вы можете отобразить алерт или выполнить другие действия
//            showAlert()
        }
    }
    
    func setupLanguagePicker() {
        languagePicker.delegate = self
        languagePicker.dataSource = self
        languagePicker.backgroundColor = .black.withAlphaComponent(0.7)
        
        // Создание градиента
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        // Добавляем градиентный слой на основной вью
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(languagePicker)

        // Устанавливаем ограничения для пикера
        languagePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languagePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languagePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            languagePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            languagePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupAlertButton() {
        alertButton.setTitle("LanguageSelectionView.Button.Text.Confirm".localized(), for: .normal)
        alertButton.backgroundColor = UIColor.systemBlue
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.layer.cornerRadius = 10
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside) // Добавляем обработчик нажатия
        
        view.addSubview(alertButton)
        
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70) // Отступ снизу
        ])
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(
            title: "LanguageSelectionView.Title".localized(),
            message: "LanguageSelectionView.Text".localized(),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .destructive, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
//            exit(0)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true)
    }

    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = languages[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor.white])
        return myTitle
    }
    
    // Прокрутка пикера к текущему языку
    func scrollToCurrentLanguage() {
        let currentLanguageCode = UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.current.languageCode ?? "en"
        
        if let index = languageCodes.firstIndex(of: currentLanguageCode) {
            languagePicker.selectRow(index, inComponent: 0, animated: true)
        }
    }
    
    // MARK: - UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLanguageCode = languageCodes[row]
        
        UserDefaults.standard.set(selectedLanguageCode, forKey: "appLanguage")
        Bundle.setLanguage(selectedLanguageCode)
        updateUI()
    }
    
    func updateUI() {
        label.text = "LanguageSelectionView.Text".localized()
        alertButton.setTitle("LanguageSelectionView.Button.Text.Confirm".localized(), for: .normal)
    }
}

extension Bundle {
    private static var bundle: Bundle?

    public static func setLanguage(_ language: String) {
        // Ищем путь к файлам локализации для выбранного языка
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        if let path = path {
            bundle = Bundle(path: path)
        } else {
            bundle = Bundle.main // Если язык не найден, используем основной Bundle
        }
    }
    
    // Переопределение метода для получения строки локализации
    public static func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return bundle?.localizedString(forKey: key, value: value, table: tableName) ?? Bundle.main.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension String {
    func localized() -> String {
        // Используем переопределённый метод в Bundle
        return Bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
