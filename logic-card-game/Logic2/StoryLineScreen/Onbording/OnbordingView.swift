//
//  OnbordingView.swift
//  Logic2
//
//  Created by Mikita on 22.09.24.
//

import UIKit
import SnapKit

class OnbordingView: UIView {

    private var collectionView: UICollectionView!
    private var currentIndexPath = IndexPath(item: 0, section: 0)
    private let gradientLayer = CAGradientLayer()
    private var viewModel = OnboardingViewModel().mainOnbordingData
    
    var goToMainScreenHandler: (() -> Void)?

    func setup() {
        setupGradientBackground()
        setupCollectionView()
        setupGestureRecognizers()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradientBackground() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.blue.cgColor,
            UIColor.cyan.cgColor,
            UIColor.systemBlue.cgColor,
            UIColor.purple.cgColor,
            UIColor.magenta.cgColor,
            UIColor.systemPink.cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0] // Отношения для расположения цветов

        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellWidth = UIScreen.main.bounds.width * 0.8 // Ширина ячейки
        let cellHeight = UIScreen.main.bounds.height // Высота ячейки
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 20 // Расстояние между ячейками
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false // Отключаем пейджинг, чтобы использовать жесты свайпа
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        // Устанавливаем отступы так, чтобы ячейки выступали слева и справа
        let inset = (UIScreen.main.bounds.width - cellWidth) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    private func setupGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard gesture.direction == .left else { return }
        
        let currentIndex = currentIndexPath.item
        let totalItems = collectionView.numberOfItems(inSection: 0)
        
        var targetIndex = currentIndex
        
        targetIndex = min(currentIndex + 1, totalItems - 1)
//        if gesture.direction == .left {
//            targetIndex = min(currentIndex + 1, totalItems - 1)
//        } else if gesture.direction == .right {
//            targetIndex = max(currentIndex - 1, 0)
//        }
        
        currentIndexPath = IndexPath(item: targetIndex, section: 0)
        
        // Используем `scrollToItem(at:at:animated:)` для скролла
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
    }

}

extension OnbordingView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        
        let data = viewModel[indexPath.item]
        cell.setup(image: data.image, text: data.text)
        
        cell.nextHandler = { [weak self] in
            guard let self else { return }
            if indexPath.item == self.viewModel.count - 1 {
                self.goToMainScreenHandler?()
                self.removeFromSuperview()
            } else {
                let currentIndex = self.currentIndexPath.item
                let totalItems = collectionView.numberOfItems(inSection: 0)
                var targetIndex = currentIndex
                targetIndex = min(currentIndex + 1, totalItems - 1)
                self.currentIndexPath = IndexPath(item: targetIndex, section: 0)
                collectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: true)
            }
        }
        
        cell.skipHandler = { [weak self] in
            self?.goToMainScreenHandler?()
            self?.removeFromSuperview()
        }
        
        return cell
    }

    // Определяем размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.8, height: collectionView.bounds.height)
    }
}

