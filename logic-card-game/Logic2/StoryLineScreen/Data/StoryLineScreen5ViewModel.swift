//
//  StoryLineScreen5ViewModel.swift
//  Logic2
//
//  Created by никита уваров on 16.09.24.
//


import Foundation
import UIKit

class StoryLineScreen5ViewModel: StoryLineScreenViewModelProtocol {

    
    let goToNextText = ""
    let Textbefore = ""

    let data1: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView5.question1".localized(),
            answer1: "StoryLineScreenView5.answer11".localized(),
            answer2: "StoryLineScreenView5.answer12".localized(),
            image: UIImage(named: "Robots113")
        ),
        StoryLineModel(
            question: "",
            answer1: "",
            answer2: "",
            image: UIImage(named: "Robots112")
        ),
    ]
    
    let data2: [StoryLineModel] = [
        StoryLineModel(
            question: "StoryLineScreenView5.question1".localized(),
            answer1: "StoryLineScreenView5.answer11".localized(),
            answer2: "StoryLineScreenView5.answer12".localized(),
            image: UIImage(named: "Robots113")
        ),
        StoryLineModel(
            question: "",
            answer1: "",
            answer2: "",
            image: UIImage(named: "Robots112")
        ),
        
    ]
    
    let firstMessages: [String] = [
       
       
       
    ]
    
    let secondMessages: [String] = [
       
       
    ]
    
    let firstMessages2: [String] = [
        
        
        
    ]
    
    let secondMessages2: [String] = [
       
    ]
}
