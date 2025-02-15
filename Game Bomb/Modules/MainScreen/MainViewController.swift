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
    
    private let rules = [
        ("Все игроки становятся в круг.", nil),
        ("Первый игрок берет телефон и нажимает кнопку:", UIImage(named: "startButton")),
        ("На экране появляется вопрос “Назовите Фрукт”.", nil),
        ("Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку.", nil),
        ("Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.", nil),
        ("Проигравшим считается тот, в чьих руках взорвалась бомба.", nil),
        ("Если выбран режим игры “С Заданиями”, то проигравший выполняет задание.", nil)
    ]
    
    //    MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "setting"), style: .done, target: self, action: #selector(didTapSettingButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "questionRed1"), style: .plain, target: self, action: #selector(didTapQuestionButton))
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        rulesView.delegate = self
        rulesView.isHidden = true
        rulesView.tableView.dataSource = self
        rulesView.tableView.delegate = self
       
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        setupView()
        setupConstraints()
        buttonPushed()
        
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    //    MARK: - Methods
    @objc func swipeView(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 1.0) {
            if sender.direction == .down {
                self.rulesView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.rulesView.frame.size.width, height: self.rulesView.frame.size.height)
            }
        }
    }
    
    @objc func didTapSettingButton() {
        let categoryVC = SettingViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    @objc func didTapQuestionButton() {
        UIView.animate(withDuration: 1.0) {
            self.rulesView.frame = CGRect(x: 0, y: 0, width: self.rulesView.frame.size.width, height: self.rulesView.frame.size.height)
            self.rulesView.isHidden = false
        }
        rulesView.isHidden = false
        rulesView.backgroundColor = .customwhite
        view.addSubview(rulesView)
        NSLayoutConstraint.activate([
            rulesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.73),
            rulesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rulesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rulesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
    //    MARK: - Actions
    @objc
    private func buttonPush() {
        let gameController = GameViewController()
        navigationController?.pushViewController(gameController, animated: true)
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
        cell.configureCell(number: indexPath.row + 1, description: attributedText, image: rule.1)
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
