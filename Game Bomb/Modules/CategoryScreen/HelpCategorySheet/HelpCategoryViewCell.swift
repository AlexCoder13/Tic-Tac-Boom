//
//  HelpCategoryViewCell.swift
//  Game Bomb
//
//  Created by Анна on 12.02.2025.
//

import UIKit


class HelpCategoryViewCell: UICollectionViewCell {
    // MARK: - GUI Variables
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 16)
        label.textColor = .label
        
        return label
    }()
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkImage")
        
        return imageView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupShadow()
        backgroundColor = .customLightGray
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
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        
        layer.masksToBounds = false
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(iconImageView)
        addSubview(checkImageView)
        
        setupConstraints()
    }
    
    private func  setupConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    //MARK: - Methods
    func configure(with category: Category) {
        titleLabel.text = category.name
        iconImageView.image = category.icon
    }
}
