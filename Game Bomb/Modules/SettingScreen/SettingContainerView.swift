//
//  SettingContainerView.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit


class SettingContainerView: UIView {
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupShadow()
        
        backgroundColor = .CustomColors.gray
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.08
        
        layer.masksToBounds = false
    }
}
