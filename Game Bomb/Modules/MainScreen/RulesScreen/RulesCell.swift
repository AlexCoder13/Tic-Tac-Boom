//
//  RulesCell.swift
//  Game Bomb
//
//  Created by Екатерина Орлова on 12.02.2025.
//

import UIKit

 class RulesCell: UITableViewCell {
     //    MARK: - Properties
     static let identifier = RulesCell.description()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .CustomColors.mainBackground
        label.font = .custom(font: .bold, size: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
     let imageButton: UIImageView = {
         let image = UIImageView()
         image.contentMode = .scaleAspectFill
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
     }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//     MARK: - Methods
    func setupUI() {
        shadowView.addSubview(numberLabel)
        [
            shadowView,
            descriptionLabel,
            imageButton
        ].forEach {
            contentView.addSubview($0)
        }
    }
     
     func configureCell(number: Int, description: NSAttributedString?, image: UIImage?) {
         numberLabel.text = "\(number)"
         descriptionLabel.attributedText = description
         imageButton.image = image
     }
}

// MARK: - Extensions Constraint
extension RulesCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shadowView.widthAnchor.constraint(equalToConstant: 29),
            shadowView.heightAnchor.constraint(equalToConstant: 29),

            numberLabel.widthAnchor.constraint(equalToConstant: 29),
            numberLabel.heightAnchor.constraint(equalToConstant: 29),
            numberLabel.topAnchor.constraint(equalTo: shadowView.topAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            imageButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            imageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageButton.heightAnchor.constraint(equalToConstant: 20),
            imageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
    }
}
