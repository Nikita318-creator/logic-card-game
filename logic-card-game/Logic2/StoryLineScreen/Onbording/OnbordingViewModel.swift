//
//  OnbordingViewModel.swift
//  Logic2
//
//  Created by Mikita on 22.09.24.
//

import UIKit

struct OnboardingModel {
    let image: UIImage?
    let text: String
}

class OnboardingViewModel {
    var mainOnbordingData: [OnboardingModel] = [
        OnboardingModel(image: UIImage(named: "BackGraunds3"), text: "OnboardingCell.Main.Text1".localized()),
        OnboardingModel(image: UIImage(named: "BackGraunds1"), text: "OnboardingCell.Main.Text2".localized()),
        OnboardingModel(image: UIImage(named: "BackGraunds5"), text: "OnboardingCell.Main.Text3".localized()),
        OnboardingModel(image: UIImage(named: "BackGraunds4"), text: "OnboardingCell.Main.Text4".localized()),
    ]
}
