//
//  RevardsHelper.swift
//  Logic2
//
//  Created by Mikita on 22.09.24.
//

import UIKit

class RevardsHelper {
    
    static var shared = RevardsHelper()
    
    private init() { }
    
    func updateFinishedLevel(_ index: Int) {
        var finished = getFinishedRevards()
        finished.append(index)
        saveFinishedRevards(finished)
    }
    
    private func saveFinishedRevards(_ levels: [Int]) {
        UserDefaults.standard.set(Array(Set(levels)), forKey: "FinishedRevards")
    }
    
    func getFinishedRevards() -> [Int] {
        return UserDefaults.standard.array(forKey: "FinishedRevards") as? [Int] ?? []
    }
}
