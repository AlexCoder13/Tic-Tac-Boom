//
//  SettingTimeView.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

enum SettingTimeType: String, CaseIterable {
    case short = "Короткое"
    case medium = "Среднее"
    case long = "Длинное"
    case random = "Случайное"
    
    var timeValue: Int {
        switch self {
        case .short:
            return 10
        case .medium:
            return 20
        case .long:
            return 45
        case .random:
            return [10, 15, 20, 25, 30, 35, 40, 45].randomElement() ?? 10
        }
    }
}

final class SettingTimeView: SettingContainerView {
    // MARK: - GUI Variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Время игры".uppercased()
        label.font = .custom(font: .medium, size: 20)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(SettingTimeViewCell.self, forCellWithReuseIdentifier: "SettingTimeViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        
        return collectionView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func selectSavedTime() {
        let savedTime = GameSettings.shared.getGameSettings().time
        if let selectedIndex = SettingTimeType.allCases.firstIndex(where: { $0.timeValue == savedTime }) {
            let indexPath = IndexPath(item: selectedIndex, section: 0)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = .CustomColors.yellow
        }
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28),
            collectionView.heightAnchor.constraint(equalToConstant: getCollectionHeight())
        ])
    }
    
    private func getCollectionHeight() -> CGFloat {
        let itemCount = CGFloat(SettingTimeType.allCases.count)
        let rows = ceil(itemCount / 2)
        let itemHeight: CGFloat = 40
        let spacing: CGFloat = 20 * (rows - 1)
        return rows * itemHeight + spacing
    }
}

//MARK: - UICollectionViewDataSource
extension SettingTimeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingTimeType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingTimeViewCell", for: indexPath) as! SettingTimeViewCell
        let type = SettingTimeType.allCases[indexPath.item]
        cell.configure(with: type)
        
        selectSavedTime()
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SettingTimeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tapedTimeButton = SettingTimeType.allCases[indexPath.item]
        let selectedTime = tapedTimeButton.timeValue
        print("Продолжительность игры: \(selectedTime)")
        GameSettings.shared.saveGameSettings(Settings(time: selectedTime))
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .CustomColors.yellow
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .CustomColors.darkGray
    }
    
}

//MARK: -  UICollectionViewDelegateFlowLayout
extension SettingTimeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 66) / 2
        return CGSize(width: width, height: 40)
    }
}
