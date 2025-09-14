//
//  SceneDelegate.swift
//  Logic2
//
//  Created by никита уваров on 10.09.24.
//

import UIKit
import GoogleMobileAds

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var adBannerView: GADBannerView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        NotificationCenter.default.addObserver(self, selector: #selector(removeAdBannerView), name: Notification.Name("stopAdds"), object: nil)
        
        // Установите SplashViewController как корневой контроллер
        let splashViewController = SplashViewController()
        splashViewController.showMainAppScreenHandler = {
            self.startMainScreen()
        }
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
    
    private func startMainScreen(isInAppEvent: Bool = false) {
        let initialViewController = ViewController()
        initialViewController.isInAppEvent = isInAppEvent
        let navigationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationController
        
        // Создайте UIView для баннера
        if !PurchasedLogicHelper.shared.getShowAdds() {
            setupAdBannerView()
        }
    }
    
    private func setupAdBannerView() {
        guard let window = window else { return }

        // Инициализация баннера
        adBannerView = GADBannerView(adSize: GADAdSizeBanner)
        adBannerView?.adUnitID = "ca-app-pub-6969606246892234/8407066108"  // todo
//        adBannerView?.adUnitID = "ca-app-pub-3940256099942544/2934735716" // test
        adBannerView?.delegate = self
        adBannerView?.rootViewController = window.rootViewController

        // Добавляем баннер на окно
        window.addSubview(adBannerView!)

        // Установите ограничения для баннера
        adBannerView?.translatesAutoresizingMaskIntoConstraints = false
        adBannerView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        adBannerView?.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        adBannerView?.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
        adBannerView?.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor).isActive = true

        // Загрузите рекламу
        adBannerView?.load(GADRequest())
    }

    @objc private func removeAdBannerView() {
        if let adBannerView = adBannerView {
            adBannerView.removeFromSuperview()
            self.adBannerView = nil
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
         guard let urlContext = URLContexts.first else { return }
         let url = urlContext.url

         // Проверяем, что схема URL соответствует твоей схеме (aievolution://)
         if url.scheme == "aievolution" {
             // Обрабатываем ссылку и открываем нужный экран
             // Например, если URL - "aievolution://event123", то можно извлечь информацию о событии
             if let host = url.host {
                 handleDeepLink(event: host)
             }
         }
     }

    func handleDeepLink(event: String) {
        if event == "event10coinstarter" {
            if let rootViewController = window?.rootViewController as? UINavigationController {
                startMainScreen(isInAppEvent: true)
            }
        } else {
            print("Неизвестное событие: \(event)")
        }
    }
}

extension SceneDelegate: GADBannerViewDelegate {
    func adViewDidLoad(_ bannerView: GADBannerView) {
        print("Banner loaded")
    }

    func adViewDidFailToReceiveAdWithError(_ bannerView: GADBannerView, error: Error) {
        print("Failed to load banner: \(error.localizedDescription)")
    }
}
