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
    
    }
}

