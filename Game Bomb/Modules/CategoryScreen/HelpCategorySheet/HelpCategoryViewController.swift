//
//  HelpCategoryViewController.swift
//  Game Bomb
//
//  Created by Анна on 12.02.2025.
//


import UIKit

class HelpCategoryViewController: UIViewController {
    private var categories: [Category] = [
        Category(name: "О Разном", icon: UIImage(named: "different"), label: "anotherQuestions"),
        Category(name: "Спорт и хобби", icon: UIImage(named: "sport"), label: "sportQuestions"),
        Category(name: "Про жизнь", icon: UIImage(named: "life"), label: "lifeQuestions"),
        Category(name: "Знаменитости", icon: UIImage(named: "celebrities"), label: "famousQuestions")
    ]
    
    // MARK: - GUI Variables
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkGray
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 30)
        label.textColor = .customDarkGray
        label.text = "Правила игры"
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .medium, size: 24)
        label.textColor = .customDarkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "В игре доступно 6 категорий и более 90 вопросов."
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .light, size: 24)
        label.textColor = .customDarkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Можно выбрать сразу несколько категорий для игры."
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HelpCategoryViewCell.self, forCellWithReuseIdentifier: "HelpCategoryViewCell")
        collectionView.allowsMultipleSelection = true
        
        return collectionView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "helpBackground")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .CustomColors.yellow
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.addSubview(lineView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(collectionView)
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        
        setupConstraints()
    }
    
    private func  setupConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.widthAnchor.constraint(equalToConstant: 68),
            
            titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 6),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            subTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            collectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension HelpCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelpCategoryViewCell", for: indexPath) as! HelpCategoryViewCell
        let category = categories[indexPath.item]
        cell.configure(with: category)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HelpCategoryViewController: UICollectionViewDelegate {
    
}

//MARK: -  UICollectionViewDelegateFlowLayout
extension HelpCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 76) / 2
        return CGSize(width: width, height: 150)
    }
}

