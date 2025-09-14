//
//  UIViewController+rateApp.swift
//  Logic2
//
//  Created by Mikita on 21.09.24.
//

import UIKit
import StoreKit

extension UIViewController {
    func requestAppReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            // Использовать старый способ для iOS ниже 14.0
            SKStoreReviewController.requestReview()
        }
    }
}
