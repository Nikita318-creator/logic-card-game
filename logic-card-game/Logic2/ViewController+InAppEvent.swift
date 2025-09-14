//
//  ViewController+InAppEvent.swift
//  Logic2
//
//  Created by Mikita on 19.01.25.
//

import UIKit

extension ViewController {
    func inAppEventRevard() {
        // Проверяем, была ли уже получена награда
        let rewardReceivedKey = "rewardReceived"
        if UserDefaults.standard.bool(forKey: rewardReceivedKey) {
            return
        }
        
        UserDefaults.standard.set(true, forKey: rewardReceivedKey)

        let storeScreenVC = StoreScreenVC()
        storeScreenVC.isInAppEvent = true
        self.navigationController?.pushViewController(storeScreenVC, animated: false)
    }
}
