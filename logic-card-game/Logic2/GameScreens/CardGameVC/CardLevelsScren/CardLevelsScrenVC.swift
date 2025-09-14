//
//  CardLevelsScrenVC.swift
//  Logic2
//
//  Created by никита уваров on 11.09.24.
//

import UIKit
import SnapKit

class CardLevelsScrenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private enum Const {
        static let screen = UIScreen.main.bounds
        static let cellHeight: CGFloat = 100 // Высота ячейки
        static let cellSpacing: CGFloat = 10 // Расстояние между ячейками
        static let sectionInset: CGFloat = 10 // Отступы с каждой стороны
        static let numberOfCellsInRow: CGFloat = 6 // Количество ячеек в ряду
    }
    
    private var collectionView: UICollectionView!
    var currentChapter: Int = 0
        
    var viewModel = CardModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionView.setContentOffset(CGPoint(x: 0, y: -200), animated: true)
//    }
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "BackGraunds3")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Const.cellSpacing
        layout.minimumInteritemSpacing = Const.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: Const.sectionInset, left: Const.sectionInset, bottom: Const.sectionInset, right: Const.sectionInset)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardLevelsScrenCell.self, forCellWithReuseIdentifier: "CardLevelsScrenCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardLevelsScrenCell", for: indexPath) as? CardLevelsScrenCell else {
            return UICollectionViewCell()
        }
        
        let currentLevel = indexPath.item
        cell.backgroundColor = .clear
        
        let isFinished: Bool
        let currentLevelprogress: LevelProgresCard

        isFinished = CardGameHelper.shared.getFinishedLevel().contains(indexPath.item)
        currentLevelprogress = CardGameHelper.shared.levelProgres[currentLevel]
        
        cell.configure(
            text: "\(indexPath.item + 1)",
            isCurrentLevel: CardGameHelper.shared.getFinishedLevel().count == currentLevel,
            isFinished: isFinished,
            currentLevelProgress: currentLevelprogress
        )
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (Const.numberOfCellsInRow - 1) * Const.cellSpacing + 2 * Const.sectionInset
        let width = (Const.screen.width - totalSpacing) / Const.numberOfCellsInRow
        let height = width + 26 // Const.cellHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Const.sectionInset, left: Const.sectionInset, bottom: Const.sectionInset, right: Const.sectionInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentLevel = indexPath.item
        let isFinished: Bool
        isFinished = CardGameHelper.shared.getFinishedLevel().contains(indexPath.item)
        
        guard isFinished || CardGameHelper.shared.getFinishedLevel().count == currentLevel else { return }
        
        CardGameHelper.shared.currentLevel = indexPath.item
        let cardGameVC = CardGameVC(viewModel: viewModel.data[indexPath.item])
        cardGameVC.isFirst = indexPath.item == 0
        self.navigationController?.pushViewController(cardGameVC, animated: false)
        
    }
}
