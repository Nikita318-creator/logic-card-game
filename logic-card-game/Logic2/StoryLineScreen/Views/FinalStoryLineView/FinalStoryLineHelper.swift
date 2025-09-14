//
//  FinalStoryLineHelper.swift
//  Logic2
//
//  Created by никита уваров on 16.09.24.
//

import UIKit

enum FinalStoryLineType: Codable {
    case workingWith
    case workingWithFinished
    case goodMan
}

enum FinalResultType: Codable {
    case type1
    case type2
}

class FinalStoryLineHelper {
    
    static var shared = FinalStoryLineHelper()
    
    private init() {
        
    }
    
//    func saveCurrentquestionNumber(_ levels: Int) {
//        UserDefaults.standard.set(levels, forKey: "CurrentquestionNumber")
//    }
//    
//    func getCurrentquestionNumber() -> Int {
//        return UserDefaults.standard.integer(forKey: "CurrentquestionNumber")
//    }
    
    func saveFinalStoryLineType(_ levels: FinalStoryLineType) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(levels) {
            UserDefaults.standard.set(encoded, forKey: "FinalStoryLineType")
        }
    }
    
    func getFinalStoryLineType() -> FinalStoryLineType {
        if let savedData = UserDefaults.standard.data(forKey: "FinalStoryLineType") {
            let decoder = JSONDecoder()
            if let loadedProgress = try? decoder.decode(FinalStoryLineType.self, from: savedData) {
                return loadedProgress
            }
        }
        return .goodMan // Значение по умолчанию
    }
    
    func saveFinalResultType(_ levels: FinalResultType) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(levels) {
            UserDefaults.standard.set(encoded, forKey: "FinalResultType")
        }
    }
    
    func getFinalResultType() -> FinalResultType {
        if let savedData = UserDefaults.standard.data(forKey: "FinalResultType") {
            let decoder = JSONDecoder()
            if let loadedProgress = try? decoder.decode(FinalResultType.self, from: savedData) {
                return loadedProgress
            }
        }
        return .type1 // Значение по умолчанию
    }
}
