//
//  ConsiderGameHelper.swift
//  Logic2
//
//  Created by никита уваров on 13.09.24.
//

import UIKit

class ConsiderGameHelper {
    
    private(set) var levelProgres: [LevelProgresCard] = []
    private let defaults = UserDefaults.standard

    let maxErrorCount = 1
    let maxSecondsCount: Double = 20

    var currentLevel = 0
    
    static var shared = ConsiderGameHelper()
    
    private init() {
        loadLevelProgres()
        if levelProgres.isEmpty {
            levelProgres = (0...49).map { _ in LevelProgresCard() }
            saveLevelProgres()
        }
    }
    
    func updateFinishedLevel(_ index: Int) {
        var finished = getFinishedLevel()
        finished.append(index)
        saveFinishedLevel(finished)
    }
    
    private func saveFinishedLevel(_ levels: [Int]) {
        UserDefaults.standard.set(Array(Set(levels)), forKey: "finishedLevelConsider")
    }
    
    func getFinishedLevel() -> [Int] {
        return UserDefaults.standard.array(forKey: "finishedLevelConsider") as? [Int] ?? []
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
            defaults.set(encoded, forKey: "finishedLevelConsiderProgress")
        }
    }
    
    private func loadLevelProgres() {
        if let savedData = defaults.object(forKey: "finishedLevelConsiderProgress") as? Data {
            let decoder = JSONDecoder()
            if let loadedProgres = try? decoder.decode([LevelProgresCard].self, from: savedData) {
                levelProgres = loadedProgres
            }
        }
    }
}
