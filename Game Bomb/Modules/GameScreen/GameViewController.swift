//
//  GameViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    private let gameView = GameView()
    
    var audioPlayer: AVAudioPlayer?
    
    private var timer = Timer()
    private var currentSeconds = 0
    private var secondsForGame = [15, 20, 25, 30, 35, 40]
    
    //    MARK: - LifeCycle
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        gameView.startButton.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pause.circle"), style: .done, target: self, action: #selector(stopTimer))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    private func setupView() {
        view.addSubview(gameView.backImageView)
        view.addSubview(gameView.gameLabel)
        view.addSubview(gameView.questuonLabel)
        view.addSubview(gameView.bombImage)
        view.addSubview(gameView.startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameView.backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            gameView.gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            gameView.gameLabel.heightAnchor.constraint(equalToConstant: 40),
            gameView.gameLabel.widthAnchor.constraint(equalToConstant: 185),
            
            gameView.questuonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.questuonLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            gameView.questuonLabel.heightAnchor.constraint(equalToConstant: 96),
            gameView.questuonLabel.widthAnchor.constraint(equalToConstant: 329),
            
            gameView.bombImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.bombImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameView.bombImage.heightAnchor.constraint(equalToConstant: 392),
            gameView.bombImage.widthAnchor.constraint(equalToConstant: 312),
            
            gameView.startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62),
            gameView.startButton.heightAnchor.constraint(equalToConstant: 55),
            gameView.startButton.widthAnchor.constraint(equalToConstant: 330)
        ])
    }
    
//    private func playSound(_ sound: String) {
//        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
//            let url = URL(fileURLWithPath: path)
//            if audioPlayer == nil {
//                do {
//                    audioPlayer = try AVAudioPlayer(contentsOf: url)
//                    audioPlayer?.play()
//                } catch {
//                    print("Ошибка при воспроизведении звука: \(error.localizedDescription)")
//                }
//            }
//        } else {
//            print("Файл не найден")
//        }
//    }
    
    private func playSound(_ sound: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Ошибка при воспроизведении звука: \(error.localizedDescription)")
            }
        } else {
            print("Файл не найден")
        }
    }
    
    @objc
    private func pushButton() {
        timer.invalidate()
        currentSeconds = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        gameView.questuonLabel.text = "*Вопрос из категории*"
        gameView.questuonLabel.font = .custom(font: .bold, size: 28)
        gameView.startButton.isHidden = true
    }
    
    @objc
    private func popProfileButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func stopTimer() {
        print("Timer Stoped")
        timer.invalidate()
        
        audioPlayer?.stop()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.circle"), style: .done, target: self, action: #selector(resumeTimer))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    @objc
    private func resumeTimer() {
        print("Timer Resumed")
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pause.circle"), style: .done, target: self, action: #selector(stopTimer))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    @objc
    private func updateTimer() {
        if  self.currentSeconds < self.secondsForGame.randomElement() ?? 30 {
            playSound("soundBomb")
            self.currentSeconds += 1
            print("Игра началась \(currentSeconds)")
        } else {
            timer.invalidate()
            playSound("soundBoom")
            gameView.bombImage.image = UIImage(named: "Boom Image")
            gameView.gameLabel.text = "Конец Игры"
            gameView.gameLabel.font = .custom(font: .bold, size: 28)
            gameView.questuonLabel.isHidden = true
            navigationItem.rightBarButtonItem?.isHidden = true
            print("Игра окончена \(currentSeconds)")
        }
    }
}
