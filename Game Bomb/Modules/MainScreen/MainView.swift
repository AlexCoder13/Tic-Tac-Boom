//
//  MainView.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func didTapStartButton()
    func didTapCategoryButton()
}

final class MainView: UIView {
    //    MARK: - Properties
    weak var delegate: MainViewDelegate?
    
    //    MARK: - Private Properties
    private let backImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundMain")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let gameLabel: UILabel = {
        let label = UILabel()
        label.text = "ИГРА ДЛЯ КОМПАНИИ"
        label.font = .custom(font: .bold, size: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowRadius = 4
        label.layer.shadowOpacity = 0.4
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gameBombLabel: UILabel = {
        let label = UILabel()
        label.text = "БОМБА"
        label.font = .custom(font: .bold, size: 48)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        label.layer.shadowOpacity = 0.4
        label.layer.masksToBounds = false
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
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.25
        button.layer.masksToBounds = false
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
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.25
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setActions()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Methods
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        
        layer.masksToBounds = false
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

    private func setActions() {
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(didTapCategoryButton), for: .touchUpInside)
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
            
            bombImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bombImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bombImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bombImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            buttonsStack.topAnchor.constraint(equalTo: bombImageView.bottomAnchor, constant: 50),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalToConstant: 140),
            buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Extensions MainView
extension MainView {
    @objc func didTapStartButton() {
        delegate?.didTapStartButton()
    }
    @objc func didTapCategoryButton() {
        delegate?.didTapCategoryButton()
    }
}
