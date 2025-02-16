//
//  FinalView.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

protocol FinalViewDelegate: AnyObject {
    func anotherQuestionButtonTapped()
    func startAgainButtonTapped()
}

final class FinalView: UIView {
    // MARK: - Properties
    weak var delegate: FinalViewDelegate?
    let finalModel = FinalModel()
    
    lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = .CustomImage.grayBackground
        backImageView.contentMode = .scaleAspectFill
        backImageView.isUserInteractionEnabled = false
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        return backImageView
    }()
    
    lazy var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.text = K.endGameTitle
        gameLabel.textColor = .CustomColors.darkGray
        gameLabel.font = .custom(font: .bold, size: 30)
        gameLabel.textAlignment = .center
        gameLabel.numberOfLines = 0
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameLabel
    }()
    
    lazy var questuonLabel: UILabel = {
        let questuonLabel = UILabel()
        questuonLabel.text = finalModel.prepeareLoss()
        questuonLabel.textColor = .CustomColors.darkGray
        questuonLabel.font = .custom(font: .medium, size: 20)
        questuonLabel.textAlignment = .center
        questuonLabel.numberOfLines = 0
        questuonLabel.translatesAutoresizingMaskIntoConstraints = false
        return questuonLabel
    }()
    
    lazy var boomImage: UIImageView = {
        let boomImage = UIImageView()
        boomImage.image = .CustomImage.boom
        boomImage.isHidden = false
        boomImage.translatesAutoresizingMaskIntoConstraints = false
        return boomImage
    }()
    
    lazy var anotherQuestionButton: UIButton = {
        let anotherQuestionButton = UIButton()
        anotherQuestionButton.setTitle(K.loseTitle, for: .normal)
        anotherQuestionButton.setTitleColor(.CustomColors.darkGray, for: .normal)
        anotherQuestionButton.backgroundColor = .CustomColors.yellow
        anotherQuestionButton.titleLabel?.font = .custom(font: .medium, size: 20)
        anotherQuestionButton.isHidden = false
        anotherQuestionButton.layer.cornerRadius = 10
        anotherQuestionButton.addTarget(self, action: #selector(anotherQuestionButtonAction), for: .touchUpInside)
        anotherQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        return anotherQuestionButton
    }()
    
    lazy var startAgainButton: UIButton = {
        let startAgainButton = UIButton()
        startAgainButton.setTitle(K.restartGameTitle, for: .normal)
        startAgainButton.setTitleColor(.CustomColors.darkGray, for: .normal)
        startAgainButton.backgroundColor = .CustomColors.yellow
        startAgainButton.titleLabel?.font = .custom(font: .medium, size: 20)
        startAgainButton.isHidden = false
        startAgainButton.layer.cornerRadius = 10
        startAgainButton.addTarget(self, action: #selector(startAgainButtonAction), for: .touchUpInside)
        startAgainButton.translatesAutoresizingMaskIntoConstraints = false
        return startAgainButton
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupUI() {
        backgroundColor = .CustomColors.gray
        [
            backImageView,
            anotherQuestionButton,
            startAgainButton
        ].forEach { addSubview($0) }
        [
            gameLabel,
            questuonLabel,
            boomImage
        ].forEach { backImageView.addSubview($0) }
    }
    
    // MARK: - Actions
    @objc private func anotherQuestionButtonAction() {
        delegate?.anotherQuestionButtonTapped()
    }
    
    @objc private func startAgainButtonAction() {
        delegate?.startAgainButtonTapped()
    }
}

// MARK: - Extensions Constraint
extension FinalView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            gameLabel.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            gameLabel.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 60),
            gameLabel.heightAnchor.constraint(equalToConstant: 45),
            gameLabel.widthAnchor.constraint(equalToConstant: 185),
            
            questuonLabel.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            questuonLabel.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -219),
            questuonLabel.heightAnchor.constraint(equalToConstant: 109),
            questuonLabel.widthAnchor.constraint(equalToConstant: 329),
            
            boomImage.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            boomImage.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 150),
            boomImage.heightAnchor.constraint(equalToConstant: 300),
            boomImage.widthAnchor.constraint(equalToConstant: 249),
            
            anotherQuestionButton.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            anotherQuestionButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -50),
            anotherQuestionButton.heightAnchor.constraint(equalToConstant: 55),
            anotherQuestionButton.widthAnchor.constraint(equalToConstant: 330),
            
            startAgainButton.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            startAgainButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -121),
            startAgainButton.heightAnchor.constraint(equalToConstant: 55),
            startAgainButton.widthAnchor.constraint(equalToConstant: 330),
        ])
    }
}
