//
//  SettingMusicViewCell.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

class SettingMusicViewCell: UICollectionViewCell {
    // MARK: - GUI Variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var selectedMusicLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 14)
        label.textColor = .CustomColors.lightGray
        label.textAlignment = .right
        
        
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "next"), for: .normal)
  
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        backgroundColor = .CustomColors.darkGray
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(selectedMusicLabel)
        addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedMusicLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            
            selectedMusicLabel.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -7),
            selectedMusicLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            nextButton.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
        ])
    }
    
    //MARK: - Methods
    func configure(with config: SettingMusicConfig) {
        titleLabel.text = config.name
        selectedMusicLabel.text = config.currentValue
    }
}
