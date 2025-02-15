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
    
    // UI Elements
    lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "gameBackView")
        backImageView.contentMode = .scaleAspectFill
        backImageView.isUserInteractionEnabled = false
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        return backImageView
    }()
    
    lazy var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.text = "Конец игры"
        gameLabel.textColor = UIColor(named: "customDarkGrayColor")
        gameLabel.font = .custom(font: .bold, size: 30)
        gameLabel.textAlignment = .center
        gameLabel.numberOfLines = 0
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameLabel
    }()
    
    lazy var questuonLabel: UILabel = {
        let questuonLabel = UILabel()
        questuonLabel.text = finalModel.prepeareLoss()
        questuonLabel.textColor = UIColor(named: "customDarkGrayColor")
        questuonLabel.font = .custom(font: .medium, size: 20)
        questuonLabel.textAlignment = .center
        questuonLabel.numberOfLines = 0
        questuonLabel.translatesAutoresizingMaskIntoConstraints = false
        return questuonLabel
    }()
    
    lazy var boomImage: UIImageView = {
        let boomImage = UIImageView()
        boomImage.image = UIImage(named: "BoomImage")
        boomImage.isHidden = false
        boomImage.translatesAutoresizingMaskIntoConstraints = false
        return boomImage
    }()
    
    lazy var anotherQuestionButton: UIButton = {
        let anotherQuestionButton = UIButton()
        anotherQuestionButton.setTitle("Другое наказание", for: .normal)
        anotherQuestionButton.setTitleColor(UIColor(named: "customDarkGrayColor"), for: .normal)
        anotherQuestionButton.backgroundColor = UIColor(named: "customyellowColor")
        anotherQuestionButton.titleLabel?.font = .custom(font: .medium, size: 20)
        anotherQuestionButton.isHidden = false
        anotherQuestionButton.layer.cornerRadius = 10
        anotherQuestionButton.layer.cornerRadius = 10
        anotherQuestionButton.layer.shadowColor = UIColor.black.cgColor
        anotherQuestionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        anotherQuestionButton.layer.shadowRadius = 4
        anotherQuestionButton.layer.shadowOpacity = 0.25
        anotherQuestionButton.layer.masksToBounds = false
        anotherQuestionButton.addTarget(self, action: #selector(anotherQuestionButtonAction), for: .touchUpInside)
        anotherQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        return anotherQuestionButton
    }()
    
    lazy var startAgainButton: UIButton = {
        let startAgainButton = UIButton()
        startAgainButton.setTitle("Начать заново", for: .normal)
        startAgainButton.setTitleColor(UIColor(named: "customDarkGrayColor"), for: .normal)
        startAgainButton.backgroundColor = UIColor(named: "customyellowColor")
        startAgainButton.titleLabel?.font = .custom(font: .medium, size: 20)
        startAgainButton.isHidden = false
        startAgainButton.layer.cornerRadius = 10
        startAgainButton.layer.cornerRadius = 10
        startAgainButton.layer.shadowColor = UIColor.black.cgColor
        startAgainButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startAgainButton.layer.shadowRadius = 4
        startAgainButton.layer.shadowOpacity = 0.25
        startAgainButton.layer.masksToBounds = false
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
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = UIColor(named: "customGrayColor")
        
        addSubview(backImageView)
        addSubview(anotherQuestionButton)
        addSubview(startAgainButton)
        backImageView.addSubview(gameLabel)
        backImageView.addSubview(questuonLabel)
        backImageView.addSubview(boomImage)
    }
    
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
    
    // MARK: - Actions
    @objc private func anotherQuestionButtonAction() {
        delegate?.anotherQuestionButtonTapped()
    }
    
    @objc private func startAgainButtonAction() {
        delegate?.startAgainButtonTapped()
    }
}
