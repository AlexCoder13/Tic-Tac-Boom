//
//  GameView.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//


import UIKit

protocol GameViewDelegate: AnyObject {
    func startButtonTapped()
}

final class GameView: UIView {
    // MARK: - Properties
    weak var delegate: GameViewDelegate?
    
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
        gameLabel.text = "Игра"
        gameLabel.textColor = UIColor(named: "customDarkGrayColor")
        gameLabel.font = .custom(font: .bold, size: 30)
        gameLabel.textAlignment = .center
        gameLabel.numberOfLines = 0
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameLabel
    }()
    
    lazy var questuonLabel: UILabel = {
        let questuonLabel = UILabel()
        questuonLabel.text = "Нажмите 'Запустить' чтобы начать игру"
        questuonLabel.textColor = UIColor(named: "customDarkGrayColor")
        questuonLabel.font = .custom(font: .medium, size: 28)
        questuonLabel.textAlignment = .center
        questuonLabel.numberOfLines = 0
        questuonLabel.translatesAutoresizingMaskIntoConstraints = false
        return questuonLabel
    }()
    
    lazy var bombImage: UIImageView = {
        let bombImage = UIImageView()
        bombImage.image = UIImage(named: "BombImage")
        bombImage.isHidden = false
        bombImage.translatesAutoresizingMaskIntoConstraints = false
        return bombImage
    }()
    
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Запустить", for: .normal)
        startButton.setTitleColor(UIColor(named: "customDarkGrayColor"), for: .normal)
        startButton.backgroundColor = UIColor(named: "customyellowColor")
        startButton.titleLabel?.font = .custom(font: .medium, size: 20)
        startButton.isHidden = false
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
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
        addSubview(startButton)
        backImageView.addSubview(gameLabel)
        backImageView.addSubview(questuonLabel)
        backImageView.addSubview(bombImage)
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
            questuonLabel.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 108),
            questuonLabel.heightAnchor.constraint(equalToConstant: 96),
            questuonLabel.widthAnchor.constraint(equalToConstant: 329),
            
            bombImage.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            bombImage.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor),
            bombImage.heightAnchor.constraint(equalToConstant: 490),
            bombImage.widthAnchor.constraint(equalToConstant: 390),
            
            startButton.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -62),
            startButton.heightAnchor.constraint(equalToConstant: 55),
            startButton.widthAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    // MARK: - Actions
    @objc private func startButtonAction() {
        delegate?.startButtonTapped()
    }
}

