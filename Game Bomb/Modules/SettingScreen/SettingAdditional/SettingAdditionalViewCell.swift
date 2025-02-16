//
//  SettingAdditionalViewCell.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

class SettingAdditionalViewCell: UICollectionViewCell {
    // MARK: - GUI Variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var enable: UISwitch = {
        let view = UISwitch()
        
        view.onTintColor = .CustomColors.yellow
        view.thumbTintColor = UIColor.white
        view.tintColor = .CustomColors.textSecondaryColor
        
        view.subviews.forEach { subview in
            subview.layer.cornerRadius = 16
            subview.frame.size = CGSize(width: 27, height: 27)
        }
        
        view.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)

        return view
    }()
    
    // MARK: - Properties
    private var setting: SettingAdditionalConfig?
    
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
        addSubview(enable)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        enable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            
            enable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            enable.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    //MARK: - Methods
    func configure(with config: SettingAdditionalConfig) {
        setting = config
        titleLabel.text = config.name
        
        enable.isOn = SettingStorage.shared.get(key: config.key) ?? false
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        guard let setting else { return }
        SettingStorage.shared.save(value: enable.isOn, key: setting.key)
    }
}
