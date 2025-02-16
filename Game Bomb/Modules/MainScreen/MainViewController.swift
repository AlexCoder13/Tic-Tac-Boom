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
    
    private let rulesView: RulesView = {
        let view = RulesView()
        view.contentMode = .bottom
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rules = K.rules
    
    //    MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationVC()
        setDelegate()
        setRulesView()
    }
    
    //    MARK: - Methods
    private func setNavigationVC() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .CustomImage.setting,
            style: .done,
            target: self,
            action: #selector(didTapSettingButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .CustomImage.redQuestion,
            style: .plain,
            target: self,
            action: #selector(didTapQuestionButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .CustomColors.textPrimaryColor
    }
    
    private func setDelegate() {
        mainView.delegate = self
        rulesView.delegate = self
        rulesView.tableView.dataSource = self
        rulesView.tableView.delegate = self
    }
    
    private func setRulesView() {
        rulesView.isHidden = true
        let swipeDown = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeView(_:))
        )
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeView(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 1.0) {
            if sender.direction == .down {
                self.rulesView.frame = CGRect(
                    x: 0,
                    y: self.view.frame.size.height,
                    width: self.rulesView.frame.size.width,
                    height: self.rulesView.frame.size.height
                )
            }
        }
    }
    
    //    MARK: - Actions
    @objc func didTapSettingButton() {
        let categoryVC = SettingViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    @objc func didTapQuestionButton() {
        UIView.animate(withDuration: 1.0) {
            self.rulesView.frame = CGRect(
                x: 0,
                y: 0,
                width: self.rulesView.frame.size.width,
                height: self.rulesView.frame.size.height
            )
            self.rulesView.isHidden = false
        }
        rulesView.isHidden = false
        rulesView.backgroundColor = .CustomColors.white
        view.addSubview(rulesView)
        NSLayoutConstraint.activate([
            rulesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.73),
            rulesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rulesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rulesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extensions MainViewDelegate
extension MainViewController: MainViewDelegate, RulesViewDelegate {
    
    func didTapStartButton() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func didTapCategoryButton() {
        let categoryVC = CategoryViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    func swipeBackButtonTapped() {
        rulesView.isHidden = true
    }
    
    @objc func didTapRightButton() {
        //Open game rules
    }
}

// MARK: - Extensions UITableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RulesCell.identifier, for: indexPath) as? RulesCell else {
            return UITableViewCell()
        }
        let rule = rules[indexPath.row]
        let attributedText = createAttributedText(for: rule.0)
        cell.configureCell(
            number: indexPath.row + 1,
            description: attributedText,
            image: rule.1
        )
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 90
        }
        return UITableView.automaticDimension
    }
    
    private func createAttributedText(for text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
