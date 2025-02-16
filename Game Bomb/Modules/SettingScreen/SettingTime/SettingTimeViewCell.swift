//
//  SettingTimeViewCell.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

class SettingTimeViewCell: UICollectionViewCell {
    // MARK: - GUI Variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
       
        backgroundColor = .customDarkGray
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupUI() {
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func  setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    //MARK: - Methods
    func configure(with type: SettingTimeType) {
        titleLabel.text = type.rawValue
    }
}
