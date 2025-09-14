//
//  StoryLineScreenVC+GooglAdds.swift
//  Logic2
//
//  Created by Mikita on 23.09.24.
//

import UIKit
import GoogleMobileAds

// MARK: - GooglAdds

extension StoryLineScreenVC: GADFullScreenContentDelegate {
    func loadInterstitialAd() {
//        let adUnitID = "ca-app-pub-4833261880378078/7765163813"
//        GADInterstitialAd.load(withAdUnitID: adUnitID, request: GADRequest()) { [weak self] ad, error in
//            if let error = error {
//                print("Failed to load interstitial ad: \(error)")
//                return
//            }
//            self?.interstitial = ad
//            self?.interstitial?.fullScreenContentDelegate = self
//            
//            // Теперь объявление загружено, можно показать его
//            if CardGameHelper.shared.isGamefirstOpend {
//                CardGameHelper.shared.isGamefirstOpend = false
//            } else {
//                self?.showInterstitialAd()
//            }
//        }
    }
    
    func showInterstitialAd() {
//        guard !PurchasedLogicHelper.shared.getShowAdds() else { return }
//
//        if let interstitial = interstitial {
//            interstitial.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//            // Показать следующий экран или выполнить другую задачу, если реклама не готова
////            transitionToNextScreen()
//        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad was dismissed")
        // Здесь нет необходимости вызывать loadInterstitialAd() напрямую
        // Вместо этого, загрузите новое объявление только когда это нужно
    }
    
    func transitionToNextScreen() {
        // Переход на другой экран
//        performSegue(withIdentifier: "ShowNextScreen", sender: self)
    }
}


// MARK: - GooglAdds Revard

extension StoryLineScreenVC {
    func adDidDismissFullScreenContentRevard(_ ad: GADFullScreenPresentingAd) {
        print("Ad was dismissed")
    }
    
    func loadRewardedAdRevard(closure: (() -> Void)? = nil) {
                let adUnitID = "ca-app-pub-6969606246892234/1260840304" // todo
//        let adUnitID = "ca-app-pub-3940256099942544/1712485313" // test
        let request = GADRequest()
        
        GADRewardedAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error)")
                return
            }
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            
//            closure?()
        }
    }

    func showRewardedAdRevard() {
        if let rewardedAd = rewardedAd {
            rewardedAd.present(fromRootViewController: self) {
                // Это будет вызвано, когда пользователь получает вознаграждение
                let reward = rewardedAd.adReward
                print("User should receive \(reward.amount) \(reward.type)")
                self.giveRewardToUserRevard()
            }
        } else {
            // Покажите другой экран или выполните альтернативное действие
            print("Rewarded ad wasn't ready")
            let alert = UIAlertController(
                title: "Sorry, ads are not available at the moment.",
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { _ in

            }))
            
            self.present(alert, animated: true, completion: nil)
//            loadRewardedAdRevard() {
//                self.showRewardedAdRevard()
//            }
        }
        
        self.loadRewardedAdRevard()
    }

    func giveRewardToUserRevard() {
        // Логика для предоставления вознаграждения пользователю
        storyLineCardGameView?.levelfinished()
    }
}
