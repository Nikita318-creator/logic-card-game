//
//  AppDelegate.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Запрос разрешения на отправку уведомлений
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Разрешение на уведомления получено")
            } else {
                print("Разрешение отклонено")
            }
        }
        
        setAppearance()
        UINavigationBar.appearance().tintColor = UIColor.systemBlue
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        Bundle.setLanguage(savedLanguage)
        
        // Запланируем уведомление при запуске
        scheduleNotification()
        
        return true
    }

    private func setAppearance() {
        // Настройка тени для текста
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        
        // Атрибуты для обычного состояния
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.boldSystemFont(ofSize: 28),
            .shadow: shadow,
            .strokeColor: UIColor.white, // Цвет обводки
            .strokeWidth: -2 // Толщина обводки (отрицательное значение)
        ]
        
        // Атрибуты для выделенного состояния
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 28),
            .shadow: shadow,
            .strokeColor: UIColor.white, // Цвет обводки
            .strokeWidth: -2 // Толщина обводки (отрицательное значение)
        ]
        
        // Применение атрибутов
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(highlightedAttributes, for: .highlighted)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Обработка отмены сеансов
    }

//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Устанавливаем уведомление при уходе в фон
//        scheduleNotification()
//    }
//    
//    func applicationWillTerminate(_ application: UIApplication) {
//        self.scheduleNotification()
//    }
    
    func scheduleNotification() {
        // Удаляем предыдущие запланированные уведомления
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        let notificationBodyTexts = [
            "UNUserNotificationCenter.Text1".localized(),
            "UNUserNotificationCenter.Text2".localized(),
            "UNUserNotificationCenter.Text3".localized(),
            "UNUserNotificationCenter.Text4".localized(),
            "UNUserNotificationCenter.Text5".localized(),
            "UNUserNotificationCenter.Text6".localized()
        ]
        
        // Настраиваем содержимое уведомления
        let content = UNMutableNotificationContent()
        content.title = "MatchMaker AI"
        content.body = notificationBodyTexts.randomElement() ?? notificationBodyTexts[0]
        content.sound = UNNotificationSound.default
        
        // Создаем триггер на 24 часа (86400 секунд)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)

        // Создаем запрос на уведомление
        let request = UNNotificationRequest(identifier: "gameReminder", content: content, trigger: trigger)
        
        // Добавляем уведомление в центр уведомлений
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
}
