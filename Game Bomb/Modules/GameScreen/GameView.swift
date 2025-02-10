//
//  GameView.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

final class GameView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "customGrayColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var gameLabel: UILabel = {
        let gameLabel = UILabel()
        gameLabel.text = "Игра"
        gameLabel.textColor = UIColor(named: "customPrimaryColor")
        gameLabel.font = .custom(font: .bold, size: 30)
        gameLabel.textAlignment = .center
        gameLabel.numberOfLines = 0
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameLabel
    }()
    
    lazy var questuonLabel: UILabel = {
        let questuonLabel = UILabel()
        questuonLabel.text = "Нажмите 'Запустить' чтобы начать игру"
        questuonLabel.textColor = UIColor(named: "customPrimaryColor")
        questuonLabel.font = .custom(font: .medium, size: 28)
        questuonLabel.textAlignment = .center
        questuonLabel.numberOfLines = 0
        questuonLabel.translatesAutoresizingMaskIntoConstraints = false
        return questuonLabel
    }()
    
    lazy var bombImage: UIImageView = {
        let bombImage = UIImageView()
        bombImage.image = UIImage(named: "Bomb image")
        bombImage.translatesAutoresizingMaskIntoConstraints = false
        return bombImage
    }()
    
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Запустить", for: .normal)
        startButton.setTitleColor(UIColor(named: "customPrimaryColor"), for: .normal)
        startButton.titleLabel?.font = .custom(font: .medium, size: 20)
        startButton.backgroundColor = UIColor(named: "customyellowColor")
        startButton.layer.cornerRadius = 10
        startButton.isHidden = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
}
