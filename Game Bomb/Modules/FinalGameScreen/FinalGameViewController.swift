//
//  FinalGameViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

class FinalGameViewController: UIViewController {
    // MARK: - Properties
    private let finalView = FinalView()
    private let finalModel = FinalModel()
    
    //    MARK: - LifeCycle
    override func loadView() {
        view = finalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        finalModel.exitGame()
    }
    
    //    MARK: - Methods
    private func setupDelegates() {
        finalView.delegate = self
    }
    
    private func setupNavigation() {
        navigationItem.hidesBackButton = true
        navigationItem.backButtonDisplayMode = .minimal
    }
}

// MARK: - Extensions FinalViewDelegate
extension FinalGameViewController: FinalViewDelegate {
    func anotherQuestionButtonTapped() {
        finalView.questuonLabel.text = finalModel.prepeareLoss()
    }
    
    func startAgainButtonTapped() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
