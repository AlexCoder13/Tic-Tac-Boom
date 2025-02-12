//
//  GameViewController.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit
import AVFoundation
import DotLottie

class GameViewController: UIViewController {
    
    private let gameView = GameView()
    
    var audioPlayer: AVAudioPlayer?
    private var tickAudioPlayer: AVAudioPlayer? // Отдельный плеер для звука таймера
    
    private var timer = Timer()
    private var currentSeconds = 0
    private var secondsForGame = [15, 20, 25, 30, 35, 40]
    
    private var animation: DotLottieAnimation?
    private var animationView: UIView?
    private var isAnimationPlaying = false
    private var animationDuration: Float = 7.3
    private var selectedTimerDuration: Int = 0
    
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupAnimation()
        prepareSounds() // Предварительно загружаем звуки
        
        gameView.startButton.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pause.circle"),
            style: .done,
            target: self,
            action: #selector(stopTimer)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    private func setupAnimation() {
        guard URL(string: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie") != nil else {
            print("Invalid Lottie URL")
            return
        }
        
        animation = DotLottieAnimation(webURL: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie", config: AnimationConfig(autoplay: false, loop: false))
        animationView = animation?.view()
        
        if let animationView = animationView {
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
    
    private func calculateAnimationSpeed() -> Float {
        // Вычисляем скорость: (Длительность анимации) / (Время таймера)
        return animationDuration / Float(selectedTimerDuration)
    }
    
    private func prepareSounds() {
        // Звук тика таймера
        if let path = Bundle.main.path(forResource: "soundBomb", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                tickAudioPlayer = try AVAudioPlayer(contentsOf: url)
                tickAudioPlayer?.prepareToPlay()
            } catch {
                print("Ошибка загрузки звука таймера: \(error)")
            }
        }
        
        // Звук взрыва
        if let path = Bundle.main.path(forResource: "soundBoom", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Ошибка загрузки звука взрыва: \(error)")
            }
        }
    }
    
    private func setupView() {
        view.addSubview(gameView.backImageView)
        view.addSubview(gameView.gameLabel)
        view.addSubview(gameView.questuonLabel)
        view.addSubview(gameView.startButton)
        view.addSubview(gameView.bombImage)
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
    
    @objc
    private func pushButton() {
        // Выбираем случайное время для таймера
        selectedTimerDuration = secondsForGame.randomElement() ?? 30
        
        // Считаем скорость анимации перед стартом
        animation?.setSpeed(speed: calculateAnimationSpeed())
        
        // Запускаем анимацию с начала
        animationView?.isHidden = false
        animation?.play()
        isAnimationPlaying = true
        
        timer.invalidate()
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        gameView.questuonLabel.text = "*Вопрос из категории*"
        gameView.questuonLabel.font = .custom(font: .bold, size: 28)
        gameView.startButton.isHidden = true
    }
    
    @objc
    private func stopTimer() {
        timer.invalidate()
        tickAudioPlayer?.stop()
        animation?.pause()
        isAnimationPlaying = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "play.circle"),
            style: .done,
            target: self,
            action: #selector(resumeTimer)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    @objc
    private func resumeTimer() {
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        tickAudioPlayer?.play()
        animation?.play()
        isAnimationPlaying = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pause.circle"),
            style: .done,
            target: self,
            action: #selector(stopTimer)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "customPrimaryColor")
    }
    
    @objc
    private func updateTimer() {
        if currentSeconds < selectedTimerDuration {
            // Воспроизводим звук через его плеер
            tickAudioPlayer?.play()
            currentSeconds += 1
            print("Игра началась \(currentSeconds)")
        } else {
            timer.invalidate()
            tickAudioPlayer?.stop()
            audioPlayer?.play() // Звук взрыва
            animation?.stop()
            animationView?.isHidden = true
            
            gameView.bombImage.isHidden = false
            gameView.bombImage.image = UIImage(named: "Boom Image")
            gameView.gameLabel.text = "Конец Игры"
            gameView.gameLabel.font = .custom(font: .bold, size: 28)
            gameView.questuonLabel.isHidden = true
            navigationItem.rightBarButtonItem?.isHidden = true
            
            //            let finalVC = FinalGameViewController()
            //            navigationController?.pushViewController(finalVC, animated: false)
            
            print("Игра окончена \(currentSeconds)")
        }
    }
}
