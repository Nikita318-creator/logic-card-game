//
//  StoryLineScreen4ViewModel.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import Foundation
import UIKit

class StoryLineScreen4ViewModel: StoryLineScreenViewModelProtocol {

    let goToNextText = "ResultStoryLineScreenView.GoToNext4".localized()
    let Textbefore = "ResultStoryLineScreenView4.Textbefore".localized()

    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView4.question1".localized(),
            answer1: "StoryLineScreenView4.answer11".localized(),
            answer2: "StoryLineScreenView4.answer12".localized(),
            image: UIImage(named: "Robots110")
        ),
        StoryLineModel(
            question: "StoryLineScreenView4.question2".localized(),
            answer1: "StoryLineScreenView4.answer21".localized(),
            answer2: "StoryLineScreenView4.answer22".localized(),
            image: UIImage(named: "Robots111")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView4.question1".localized(),
            answer1: "StoryLineScreenView4.answer11".localized(),
            answer2: "StoryLineScreenView4.answer12".localized(),
            image: UIImage(named: "Robots110")
        ),
        StoryLineModel(
            question: "StoryLineScreenView4.question2".localized(),
            answer1: "StoryLineScreenView4.answer21".localized(),
            answer2: "StoryLineScreenView4.answer22".localized(),
            image: UIImage(named: "Robots111")
        ),
    ]
    
    let firstMessages: [String] = [
        "ResultStoryLineScreenView4.level1.type1.message1".localized(),
        "ResultStoryLineScreenView4.level1.type1.message2".localized(),
        "ResultStoryLineScreenView4.level1.type1.message3".localized(),
    ]
    
    let secondMessages: [String] = [
        "ResultStoryLineScreenView4.level1.type2.message1".localized(),
        "ResultStoryLineScreenView4.level1.type2.message2".localized(),
        "ResultStoryLineScreenView4.level1.type2.message3".localized(),
    ]
    
    let firstMessages2: [String] = [
        "ResultStoryLineScreenView4.level1.type1.message1".localized(),
        "ResultStoryLineScreenView4.level1.type1.message2".localized(),
        "ResultStoryLineScreenView4.level1.type1.message3".localized(),
    ]
    
    let secondMessages2: [String] = [
        "ResultStoryLineScreenView4.level1.type2.message1".localized(),
        "ResultStoryLineScreenView4.level1.type2.message2".localized(),
        "ResultStoryLineScreenView4.level1.type2.message3".localized(),
    ]
}
