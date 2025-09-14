//
//  StoryLineScreen6ViewModel.swift
//  Logic2
//
//  Created by никита уваров on 16.09.24.
//

import Foundation
import UIKit

class StoryLineScreen6ViewModel: StoryLineScreenViewModelProtocol {

    let goToNextText = ""
    let Textbefore = ""

    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView6.question1".localized(),
            answer1: "StoryLineScreenView6.answer11".localized(),
            answer2: "StoryLineScreenView6.answer12".localized(),
            image: UIImage(named: "Robots114")
        ),
        StoryLineModel(
            question: "StoryLineScreenView6.question2".localized(),
            answer1: "StoryLineScreenView6.answer21".localized(),
            answer2: "StoryLineScreenView6.answer22".localized(),
            image: UIImage(named: "Robots115")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView6.question1".localized(),
            answer1: "StoryLineScreenView6.answer11".localized(),
            answer2: "StoryLineScreenView6.answer12".localized(),
            image: UIImage(named: "Robots114")
        ),
        StoryLineModel(
            question: "StoryLineScreenView6.question3".localized(),
            answer1: "StoryLineScreenView6.answer31".localized(),
            answer2: "StoryLineScreenView6.answer32".localized(),
            image: UIImage(named: "Robots115")
        ),
    ]
    
    let firstMessages: [String] = [
        "ResultStoryLineScreenView6.level1.type1.message1".localized(),
    ]
    
    let secondMessages: [String] = [
        "ResultStoryLineScreenView6.level1.type2.message1".localized(),
    ]
    
    let firstMessages2: [String] = [
        "ResultStoryLineScreenView6.level1.type1.message1".localized(),
    ]
    
    let secondMessages2: [String] = [
        "ResultStoryLineScreenView6.level1.type2.message1".localized(),
    ]
}
