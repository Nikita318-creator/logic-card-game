//
//  StoryLineScreenViewModel.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit

struct StoryLineModel {
    let question: String
    let answer1: String
    let answer2: String
    let image: UIImage?
}

protocol StoryLineScreenViewModelProtocol {
    var data1: [StoryLineModel] { get }
    var data2: [StoryLineModel] { get }
    var firstMessages: [String] { get }
    var secondMessages: [String] { get }
    var firstMessages2: [String] { get }
    var secondMessages2: [String] { get }
    var goToNextText: String { get }
    var Textbefore: String { get }
}

class StoryLineScreen1ViewModel: StoryLineScreenViewModelProtocol {

    let goToNextText = "ResultStoryLineScreenView.GoToNext".localized()
    let Textbefore = "ResultStoryLineScreenView.Textbefore".localized()
    
    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView.question1".localized(),
            answer1: "StoryLineScreenView.answer11".localized(),
            answer2: "StoryLineScreenView.answer12".localized(),
            image: UIImage(named: "Robots14")
        ),
        StoryLineModel(
            question: "StoryLineScreenView.question2".localized(),
            answer1: "StoryLineScreenView.answer21".localized(),
            answer2: "StoryLineScreenView.answer22".localized(),
            image: UIImage(named: "Robots15")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView.question1".localized(),
            answer1: "StoryLineScreenView.answer11".localized(),
            answer2: "StoryLineScreenView.answer12".localized(),
            image: UIImage(named: "Robots14")
        ),
        StoryLineModel(
            question: "StoryLineScreenView.question3".localized(),
            answer1: "StoryLineScreenView.answer31".localized(),
            answer2: "StoryLineScreenView.answer32".localized(),
            image: UIImage(named: "Robots15")
        ),
        
    ]
    
    let firstMessages: [String] = [
        "ResultStoryLineScreenView.level1.type1.message1".localized(),
        "ResultStoryLineScreenView.level1.type1.message2".localized(),
        "ResultStoryLineScreenView.level1.type1.message3".localized(),
        "ResultStoryLineScreenView.level1.type1.message4".localized()
    ]
    
    let secondMessages: [String] = [
        "ResultStoryLineScreenView.level1.type2.message1".localized(),
        "ResultStoryLineScreenView.level1.type2.message2".localized(),
        "ResultStoryLineScreenView.level1.type2.message3".localized(),
        "ResultStoryLineScreenView.level1.type2.message4".localized()
    ]
    
    let firstMessages2: [String] = [
        "ResultStoryLineScreenView.level1.type1.message5".localized(),
        "ResultStoryLineScreenView.level1.type1.message6".localized(),
        "ResultStoryLineScreenView.level1.type1.message7".localized(),
    ]
    
    let secondMessages2: [String] = [
        "ResultStoryLineScreenView.level1.type2.message5".localized(),
        "ResultStoryLineScreenView.level1.type2.message6".localized()
    ]
}
