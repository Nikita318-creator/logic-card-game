//
//  PurchasedLogicHelper.swift
//  Baraban
//
//  Created by никита уваров on 7.09.24.
//


import UIKit

class PurchasedLogicHelper {
    
    static var shared = PurchasedLogicHelper()
    
    private init() {

    }
    
    func saveIsFirstLounch(_ isPayed: Bool) {
        UserDefaults.standard.set(isPayed, forKey: "IsFirstLounch")
    }
    
    func getIsFirstLounch() -> Bool {
        return UserDefaults.standard.value(forKey: "IsFirstLounch") as? Bool ?? false
    }
    
    
    
    // MARK: - Adds
    
    func saveShowAdds(_ isPayed: Bool) {
        NotificationCenter.default.post(name: Notification.Name("stopAdds"), object: nil)
        UserDefaults.standard.set(isPayed, forKey: "ShowAdds")
    }
    
    func getShowAdds() -> Bool {
        return UserDefaults.standard.value(forKey: "ShowAdds") as? Bool ?? false
    }
    
    // MARK: - CardsBack
    
    func addCardsBackPurchased(purchas: Int) {
        var newPurchases = getCardsBackPurchased()
        newPurchases.append(purchas)
        saveCardsBackPurchased(newPurchases)
    }
    
    func saveCardsBackPurchased(_ purchases: [Int]) {
        UserDefaults.standard.set(Array(Set(purchases)), forKey: "CardsBackPurchased")
    }
    
    func getCardsBackPurchased() -> [Int] {
        return UserDefaults.standard.array(forKey: "CardsBackPurchased") as? [Int] ?? []
    }
    
    func saveCurrentCardsBackId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "CurrentCardsBackID")
    }
    
    func getCurrentCardsBackId() -> Int {
        return UserDefaults.standard.integer(forKey: "CurrentCardsBackID")
    }
    
    // MARK: - Coplection
    
    func addCoplectionPurchased(purchas: Int) {
        var newPurchases = getCoplectionPurchased()
        newPurchases.append(purchas)
        saveCoplectionPurchased(newPurchases)
    }
    
    func saveCoplectionPurchased(_ purchases: [Int]) {
        UserDefaults.standard.set(Array(Set(purchases)), forKey: "CoplectionPurchased")
    }
    
    func getCoplectionPurchased() -> [Int] {
        return UserDefaults.standard.array(forKey: "CoplectionPurchased") as? [Int] ?? []
    }
    
    func saveCoplectionBackId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "CoplectionBackID")
    }
    
    func getCoplectionBackId() -> Int {
        return UserDefaults.standard.integer(forKey: "CoplectionBackID")
    }
}
