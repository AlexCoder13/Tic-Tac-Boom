//
//  MainView.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

final class MainView: UIView {
    
    private let backImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let gameLabel: UILabel = {
        let label = UILabel()
        label.text = "ИГРА ДЛЯ КОМПАНИИ"
        label.font = .custom(font: .bold, size: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gameBombLabel: UILabel = {
        let label = UILabel()
        label.text = "БОМБА"
        label.font = .custom(font: .bold, size: 48)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bombImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bombMainScreen")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
   private let buttonsStack: UIStackView = {
        let stack = UIStackView()
       stack.axis = .vertical
       stack.distribution = .fillEqually
       stack.spacing = 15
       stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Старт игры", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .custom(font: .medium, size: 20)
        button.backgroundColor = .customwhite
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Категории", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .custom(font: .medium, size: 20)
        button.backgroundColor = .customwhite
        button.layer.cornerRadius = 10
//        button.addTarget(, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .mainBackground
        addSubview(backImageView)
        backImageView.addSubview(gameLabel)
        backImageView.addSubview(gameBombLabel)
        backImageView.addSubview(bombImageView)
        backImageView.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(startButton)
        buttonsStack.addArrangedSubview(categoryButton)
    }
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            gameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 20),
            gameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            gameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            gameBombLabel.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 10),
            gameBombLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            gameBombLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
//            bombImageView.topAnchor.constraint(equalTo: gameBombLabel.bottomAnchor, constant: 30),
            bombImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bombImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            bombImageView.heightAnchor.constraint(equalToConstant: 300),
            bombImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bombImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            buttonsStack.topAnchor.constraint(equalTo: bombImageView.bottomAnchor, constant: 50),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalToConstant: 150),
            buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
