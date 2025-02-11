//
//  MainViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

final class MainViewController: UIViewController {
    //    MARK: - Properties
    private let mainView = MainView()
    
    //    MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        buttonPushed()
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    private func setupView() {
//        view.addSubview(mainView.button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            mainView.button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            mainView.button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func buttonPushed() {
//        mainView.button.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
    }
    
    @objc
    private func buttonPush() {
        let gameController = GameViewController()
        navigationController?.pushViewController(gameController, animated: true)

    }
}

