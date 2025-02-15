//
//  CategoryViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

class CategoryViewController: UIViewController {
    private var categories: [Category] = [
        Category(name: "О Разном", icon: UIImage(named: "different"), questions: []),
        Category(name: "Спорт и хобби", icon: UIImage(named: "sport"), questions: []),
        Category(name: "Про жизнь", icon: UIImage(named: "life"), questions: []),
        Category(name: "Знаменитости", icon: UIImage(named: "celebrities"), questions: []),
        Category(name: "Искусство и кино", icon: UIImage(named: "artAndCinema"), questions: []),
        Category(name: "Природа", icon: UIImage(named: "nature"), questions: [])
    ]
    
    // MARK: - GUI Variables
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: "CategoryViewCell")
        collectionView.allowsMultipleSelection = true
        
        return collectionView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customwhite
        
        setupNavigationBar()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        title = "Категории"
        let backImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.backButtonTitle = ""
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.custom(font: .bold, size: 28),
            .foregroundColor: UIColor.customDarkGray
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let rightButtonImage = UIImage(named: "questionYellow")
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(didTapRightButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 88),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func didTapRightButton() {
        let bottomSheetVC = HelpCategoryViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return UIScreen.main.bounds.height * 0.75
            }]
        }
        present(bottomSheetVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        let category = categories[indexPath.item]
        cell.configure(with: category)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CategoryViewController: UICollectionViewDelegate {
    
}

//MARK: -  UICollectionViewDelegateFlowLayout
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 76) / 2
        return CGSize(width: width, height: 150)
    }
}
