//
//  CoinsHelper.swift
//  Baraban
//
//  Created by никита уваров on 29.08.24.
//

import Foundation
import UIKit

class CoinsHelper {
    
    static let shared = CoinsHelper()
    
    private let lastVisitDateKey = "lastVisitDate"
    private let consecutiveDaysKey = "consecutiveDays"
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func dailyReward() -> Bool {
        let defaults = UserDefaults.standard
        let calendar = Calendar.current
        
        // Получаем текущее время
        let now = Date()
        
        // Получаем дату начала сегодняшнего дня
        let startOfToday = calendar.startOfDay(for: now)

        // Получаем дату последнего захода из UserDefaults
        if let lastLoginDate = defaults.object(forKey: "lastLoginDate") as? Date {
            // Проверяем, был ли последний заход в текущие сутки
            if calendar.isDateInToday(lastLoginDate) {
                print("Пользователь уже заходил сегодня.")
                return false // Награда не выдается
            }
        }
        
        // Если пользователь зашел впервые за сутки, обновляем дату последнего захода
        defaults.set(startOfToday, forKey: "lastLoginDate")
        print("Это первый запуск в эти сутки. Награда выдана.")

        return true
    }
    
    func saveSpecialCoins(_ count: Int) {
        userDefaults.set(count, forKey: "SpecialCoins")
        NotificationCenter.default.post(name: Notification.Name("saveSpecialCoins"), object: nil)
    }
    
    func getSpecialCoins() -> Int {
        return userDefaults.integer(forKey: "SpecialCoins")
    }
    
    func saveSkips(_ count: Int) {
        userDefaults.set(count, forKey: "Skips")
    }
    
    func getSkips() -> Int {
        return userDefaults.integer(forKey: "Skips")
    }
    
    func saveRevil(_ count: Int) {
        userDefaults.set(count, forKey: "Revil")
    }
    
    func getRevil() -> Int {
        return userDefaults.integer(forKey: "Revil")
    }
}
