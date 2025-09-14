//
//  StoryLineScreen3ViewModel.swift
//  Logic2
//
//  Created by никита уваров on 15.09.24.
//

import UIKit

class StoryLineScreen3ViewModel: StoryLineScreenViewModelProtocol {

    let goToNextText = "ResultStoryLineScreenView.GoToNext3".localized()
    let Textbefore = "ResultStoryLineScreenView3.Textbefore".localized()

    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView3.question1".localized(),
            answer1: "StoryLineScreenView3.answer11".localized(),
            answer2: "StoryLineScreenView3.answer12".localized(),
            image: UIImage(named: "Robots18")
        ),
        StoryLineModel(
            question: "StoryLineScreenView3.question2".localized(),
            answer1: "StoryLineScreenView3.answer21".localized(),
            answer2: "StoryLineScreenView3.answer22".localized(),
            image: UIImage(named: "Robots19")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView3.question1".localized(),
            answer1: "StoryLineScreenView3.answer11".localized(),
            answer2: "StoryLineScreenView3.answer12".localized(),
            image: UIImage(named: "Robots18")
        ),
        StoryLineModel(
            question: "StoryLineScreenView3.question3".localized(),
            answer1: "StoryLineScreenView3.answer31".localized(),
            answer2: "StoryLineScreenView3.answer32".localized(),
            image: UIImage(named: "Robots19")
        ),
        
    ]
    
    let firstMessages: [String] = [
        "ResultStoryLineScreenView3.level1.type1.message1".localized(),
        "ResultStoryLineScreenView3.level1.type1.message2".localized(),
        "ResultStoryLineScreenView3.level1.type1.message3".localized(),
    ]
    
    let secondMessages: [String] = [
        "ResultStoryLineScreenView3.level1.type2.message1".localized(),
        "ResultStoryLineScreenView3.level1.type2.message2".localized(),
        "ResultStoryLineScreenView3.level1.type2.message3".localized(),
    ]
    
    let firstMessages2: [String] = [
        "ResultStoryLineScreenView3.level1.type1.message5".localized(),
        "ResultStoryLineScreenView3.level1.type1.message6".localized(),
        "ResultStoryLineScreenView3.level1.type1.message7".localized(),
    ]
    
    let secondMessages2: [String] = [
        "ResultStoryLineScreenView3.level1.type2.message5".localized(),
        "ResultStoryLineScreenView3.level1.type2.message6".localized(),
        "ResultStoryLineScreenView3.level1.type2.message7".localized()
    ]
}
