//
//  SplashViewController.swift
//  Logic2
//
//  Created by Mikita on 27.09.24.
//

import UIKit

class SplashViewController: UIViewController {
    
    var showMainAppScreenHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "mainIcon2")
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // Показать главный экран после задержки
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 2 секунды
            self.showMainAppScreen()
        }
    }
    
    func showMainAppScreen() {
        showMainAppScreenHandler?()
    }
}
