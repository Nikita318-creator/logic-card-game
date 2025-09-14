//
//  CardGameHelper.swift
//  Logic2
//
//  Created by никита уваров on 11.09.24.
//

import UIKit

struct LevelProgresCard: Codable {
    var isFinished: Bool = false
    var isError: Bool = false
    var isTime: Bool = false
}

enum AddsCoinsConst {
    static let revealCardsCost = 1
}

class CardGameHelper {
    
    private(set) var levelProgres: [LevelProgresCard] = []
    private let defaults = UserDefaults.standard

    let maxErrorCount = 20
    let maxSecondsCount: Double = 60

    var currentLevel = 0
    
    var isGamefirstOpend = true

    static var shared = CardGameHelper()
    
    private init() {
        loadLevelProgres()
        
        if levelProgres.isEmpty {
            levelProgres = (0...50).map { _ in LevelProgresCard() }
            saveLevelProgres()
        }
        else if levelProgres.count < 100 {
            let additionalCardsNeeded = 100 - levelProgres.count
            let additionalCards = (0..<additionalCardsNeeded).map { _ in LevelProgresCard() }
            levelProgres.append(contentsOf: additionalCards)
            saveLevelProgres()
        }
    }
    
    func updateFinishedLevel(_ index: Int) {
        var finished = getFinishedLevel()
        finished.append(index)
        saveFinishedLevel(finished)
    }
    
    private func saveFinishedLevel(_ levels: [Int]) {
        UserDefaults.standard.set(Array(Set(levels)), forKey: "finishedLevelCard")
    }
    
    func getFinishedLevel() -> [Int] {
        return UserDefaults.standard.array(forKey: "finishedLevelCard") as? [Int] ?? []
    }
    
    func updateLevelProgres(with levelProgres: LevelProgresCard, at index: Int) {
        guard self.levelProgres.count > index else { return }
        
        self.levelProgres[index] = levelProgres
        saveLevelProgres()
        loadLevelProgres()
    }
    
    private func saveLevelProgres() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(levelProgres) {
            defaults.set(encoded, forKey: "finishedLevelCardProgress")
        }
    }
    
    private func loadLevelProgres() {
        if let savedData = defaults.object(forKey: "finishedLevelCardProgress") as? Data {
            let decoder = JSONDecoder()
            if let loadedProgres = try? decoder.decode([LevelProgresCard].self, from: savedData) {
                levelProgres = loadedProgres
            }
        }
    }
}
