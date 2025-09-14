//
//  StoryLineHelper.swift
//  Logic2
//
//  Created by никита уваров on 14.09.24.
//

import UIKit

enum StoryLineProgress: Codable {
    case storyLine1
    case storyLineGame1
    case storyLine2
    case storyLineGame2
    case storyLine3
    case storyLineGame3
    case storyLine4 // картинки в вопросах
    case storyLineGame4
    case storyLine5 // артемин финал
    case storyLineGame5
}

class StoryLineHelper {
    
    static var shared = StoryLineHelper()
    
    private init() {
        
    }
    
    func saveCurrentquestionNumber(_ levels: Int) {
        UserDefaults.standard.set(levels, forKey: "CurrentquestionNumber")
    }
    
    func getCurrentquestionNumber() -> Int {
        return UserDefaults.standard.integer(forKey: "CurrentquestionNumber")
    }
    
    func saveStoryLineProgress(_ levels: StoryLineProgress) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(levels) {
            UserDefaults.standard.set(encoded, forKey: "StoryLineProgress")
        }
    }
    
    func getStoryLineProgress() -> StoryLineProgress {
        if let savedData = UserDefaults.standard.data(forKey: "StoryLineProgress") {
            let decoder = JSONDecoder()
            if let loadedProgress = try? decoder.decode(StoryLineProgress.self, from: savedData) {
                return loadedProgress
            }
        }
        return .storyLine1 // Значение по умолчанию
    }
    
    func saveIsOnbordingFinished(_ levels: Bool) {
        UserDefaults.standard.set(levels, forKey: "IsOnbordingFinished")
    }
    
    func getIsOnbordingFinished() -> Bool {
        return UserDefaults.standard.bool(forKey: "IsOnbordingFinished")
    }
}
