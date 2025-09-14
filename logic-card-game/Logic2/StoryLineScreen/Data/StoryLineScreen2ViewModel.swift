//
//  StoryLineScreen2ViewModel.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import UIKit

class StoryLineScreen2ViewModel: StoryLineScreenViewModelProtocol {

    let goToNextText = "ResultStoryLineScreenView.GoToNext2".localized()
    let Textbefore = "ResultStoryLineScreenView2.Textbefore".localized()

    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView2.question1".localized(),
            answer1: "StoryLineScreenView2.answer11".localized(),
            answer2: "StoryLineScreenView2.answer12".localized(),
            image: UIImage(named: "Robots16")
        ),
        StoryLineModel(
            question: "StoryLineScreenView2.question2".localized(),
            answer1: "StoryLineScreenView2.answer21".localized(),
            answer2: "StoryLineScreenView2.answer22".localized(),
            image: UIImage(named: "Robots17")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView2.question1".localized(),
            answer1: "StoryLineScreenView2.answer11".localized(),
            answer2: "StoryLineScreenView2.answer12".localized(),
            image: UIImage(named: "Robots16")
        ),
        StoryLineModel(
            question: "StoryLineScreenView2.question3".localized(),
            answer1: "StoryLineScreenView2.answer31".localized(),
            answer2: "StoryLineScreenView2.answer32".localized(),
            image: UIImage(named: "Robots17")
        ),
        
    ]
    
    let firstMessages: [String] = [
        "ResultStoryLineScreenView2.level1.type1.message1".localized(),
        "ResultStoryLineScreenView2.level1.type1.message2".localized(),
        "ResultStoryLineScreenView2.level1.type1.message3".localized()
    ]
    
    let secondMessages: [String] = [
        "ResultStoryLineScreenView2.level1.type2.message1".localized(),
        "ResultStoryLineScreenView2.level1.type2.message2".localized(),
    ]
    
    let firstMessages2: [String] = [
        "ResultStoryLineScreenView2.level1.type1.message5".localized(),
        "ResultStoryLineScreenView2.level1.type1.message6".localized(),
        "ResultStoryLineScreenView2.level1.type1.message7".localized(),
    ]
    
    let secondMessages2: [String] = [
        "ResultStoryLineScreenView2.level1.type2.message5".localized(),
        "ResultStoryLineScreenView2.level1.type2.message6".localized()
    ]
}
