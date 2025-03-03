//
//  GameViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//


import UIKit

final class GameViewController: UIViewController {
    // MARK: - Properties
    private let gameView = GameView()
    private let gameModel = GameModel()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupNavigation()
        gameModel.setupAnimation()
        gameModel.prepareSounds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameModel.exitGame()
    }
    
    // MARK: - Methods
    private func setupDelegates() {
        gameView.delegate = self
        gameModel.delegate = self
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: K.Player.pause),
            style: .done,
            target: self,
            action: #selector(pauseButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .CustomColors.darkGray
        navigationItem.rightBarButtonItem?.isHidden = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationItem.backAction = UIAction(handler: { _ in
            let _ = MainViewController()
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    // MARK: - Actions
    @objc private func pauseButtonTapped() {
        gameModel.pauseGame()
    }
}

// MARK: - Extensions GameViewDelegate
extension GameViewController: GameViewDelegate {
    func startButtonTapped() {
        gameView.startButton.isHidden = true
        gameView.questuonLabel.text = gameModel.prepareQuestions()
        gameView.questuonLabel.font = .custom(font: .bold, size: 20)
        gameModel.startGame()
    }
}

// MARK: - Extensions GameModelDelegate
extension GameViewController: GameModelDelegate {
    func timerDidUpdate(seconds: Int) {
        gameModel.tickAudioPlayer?.play()
        print("Игра началась \(seconds)")
    }
    
    func gameDidStart() {
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.isHidden = false
        gameView.bombImage.isHidden = true
        gameModel.animationView?.isHidden = false
        let _ = gameModel.animation?.play()
        
        if let animationView = gameModel.animationView {
            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)
            
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                animationView.heightAnchor.constraint(equalToConstant: 550),
                animationView.widthAnchor.constraint(equalToConstant: 480)
            ])
            
            animationView.isHidden = false
        }
    }
    
    func gameDidPause() {
        navigationItem.rightBarButtonItem?.isHidden = false
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: K.Player.play)
        navigationItem.rightBarButtonItem?.action = #selector(resumeButtonTapped)
    }
    
    func gameDidResume() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: K.Player.pause)
        navigationItem.rightBarButtonItem?.action = #selector(pauseButtonTapped)
        navigationItem.rightBarButtonItem?.isHidden = false
    }
    
    func gameDidEnd() {
        let finalVC = FinalGameViewController()
        navigationController?.pushViewController(finalVC, animated: false)
        gameView.questuonLabel.isHidden = true
    }
    
    @objc private func resumeButtonTapped() {
        gameModel.resumeGame()
    }
}
