//
//  BubbleButton.swift
//  Logic2
//
//  Created by Mikita on 25.09.24.
//

import Foundation

import UIKit

class BubbleButton: UIButton {
    
    private var emitterLayer: CAEmitterLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(title: String) {
        self.backgroundColor = .systemBlue
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.addTarget(self, action: #selector(startBubbleAnimation), for: .touchUpInside)
    }

    @objc private func startBubbleAnimation() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterShape = .line
        emitterLayer.emitterSize = CGSize(width: 190, height: 60) // Уменьшить размер эмиттера
        emitterLayer.emitterMode = .volume

        let cell = CAEmitterCell()
         cell.birthRate = 2
         cell.lifetime = 5.0
         cell.velocity = 100
         cell.velocityRange = 50
        cell.emissionLatitude = -CGFloat.pi
//        cell.emissionLongitude = -CGFloat.pi
         cell.spinRange = 5
         cell.scale = 0.5
         cell.scaleRange = 0.25
         cell.alphaSpeed = -0.025
        emitterLayer.emitterCells = [cell]

        // Изменение цвета пузырьков
        if let originalImage = UIImage(systemName: "star.fill") {
            let ciImage = CIImage(image: originalImage)
            let colorFilter = CIFilter(name: "CIFalseColor")!
            colorFilter.setValue(ciImage, forKey: kCIInputImageKey)
            colorFilter.setValue(CIColor(red: 0, green: 1, blue: 1, alpha: 0.5), forKey: "inputColor0") // Голубой полупрозрачный цвет
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 1, alpha: 0.5), forKey: "inputColor1") // Другой оттенок синего
            
            guard let outputImage = colorFilter.outputImage else { return }
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                cell.contents = cgImage // Используем созданный CGImage
            }
        }
        
        emitterLayer.emitterCells = [cell]
        self.layer.addSublayer(emitterLayer)
        self.emitterLayer = emitterLayer

        self.frame.size = CGSizeMake(0, 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emitterLayer.removeFromSuperlayer() // Удалить анимацию через 1 секунду
        }
    }

}
