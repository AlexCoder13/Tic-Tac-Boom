//
//  SettingViewController.swift
//  Game Bomb
//
//  Created by Анна on 14.02.2025.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - GUI Variables
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = true
        
        return view
    }()
    
    let contentView = UIView()
    
    lazy var timeView: UIView = {
        let view = SettingTimeView()
        
        return view
    }()
    
    lazy var musicView: UIView = {
        let view = SettingMusicView()
        
        return view
    }()
    
    lazy var additionalView: UIView = {
        let view = SettingAdditionalView()
        
        return view
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .CustomImage.grayBackground
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .CustomColors.white
        
        setupNavigationBar()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        title = "Настройки"
        let backImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.backButtonTitle = ""
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.custom(font: .bold, size: 28),
            .foregroundColor: UIColor.customDarkGray
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(timeView)
        contentView.addSubview(musicView)
        contentView.addSubview(additionalView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        timeView.translatesAutoresizingMaskIntoConstraints = false
        musicView.translatesAutoresizingMaskIntoConstraints = false
        additionalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            timeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            timeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            musicView.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 16),
            musicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            musicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            additionalView.topAnchor.constraint(equalTo: musicView.bottomAnchor, constant: 16),
            additionalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            additionalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            additionalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

