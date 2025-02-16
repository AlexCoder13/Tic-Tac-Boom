//
//  SettingAdditionalView.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

struct SettingAdditionalConfig {
    let key: String
    let name: String
}

final class SettingAdditionalView: SettingContainerView {
    private let configs: [SettingAdditionalConfig] = [
        .init(key: "SETTING_ADDITIONAL_VIBRATION", name: "Вибрация"),
        .init(key: "SETTING_ADDITINOAL_TUTORIAL", name: "Игра с заданиями")
    ]
    
    // MARK: - GUI Variables
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 22
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(SettingAdditionalViewCell.self, forCellWithReuseIdentifier: "SettingAdditionalViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            collectionView.heightAnchor.constraint(equalToConstant: getCollectionHeight())
        ])
    }
    
    private func getCollectionHeight() -> CGFloat {
        let itemCount = CGFloat(configs.count)
        let itemHeight: CGFloat = 49
        let spacing: CGFloat = 22 * (itemCount - 1)
        return itemCount * itemHeight + spacing
    }
}

//MARK: - UICollectionViewDataSource
extension SettingAdditionalView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingAdditionalViewCell", for: indexPath) as! SettingAdditionalViewCell
        let config = configs[indexPath.item]
        cell.configure(with: config)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SettingAdditionalView: UICollectionViewDelegate {
    
}

//MARK: -  UICollectionViewDelegateFlowLayout
extension SettingAdditionalView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 36, height: 49)
    }
}
