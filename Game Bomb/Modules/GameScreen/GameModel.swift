//
//  GameModel.swift
//  Game Bomb
//
//  Created by Александр Семёнов on 13.02.2025.
//


import UIKit
import AVFoundation
import DotLottie

protocol GameModelDelegate: AnyObject {
    func timerDidUpdate(seconds: Int)
    func gameDidStart()
    func gameDidPause()
    func gameDidResume()
    func gameDidEnd()
}

final class GameModel {
    // MARK: - Properties
    weak var delegate: GameModelDelegate?
    
    private var timer: Timer?
    private var currentSeconds = 0
    private let secondsForGame = GameSettings.shared.getGameSettings()
    private var selectedTimerDuration: Int = 0
    
    var animation: DotLottieAnimation?
    var animationView: UIView?
    private let animationDuration: Float = 7.65
    
    var audioPlayer: AVAudioPlayer?
    var tickAudioPlayer: AVAudioPlayer?
    
    // MARK: - Methods
    func setupAnimation() {
        guard URL(string: LottieConstant.url) != nil else { return }
        
        animation = DotLottieAnimation(webURL: LottieConstant.url, config: AnimationConfig(autoplay: false, loop: false))
        animationView = animation?.view()
        animationView?.isHidden = false
    }
    
    func prepareSounds() {
        loadSound(name: SoundFiles.soundBomb, player: &tickAudioPlayer)
        loadSound(name: SoundFiles.soundBoom, player: &audioPlayer)
    }
    
    func prepareQuestions() -> String {
        let questions = UserQuestionsService.shared.getSelectedQuestions()
        return questions.randomElement() ?? "Назовите вид Зимнего спорта"
    }
    
    func startGame() {
        selectedTimerDuration = secondsForGame.time
        startTimer()
        tickAudioPlayer?.play()
        animation?.setSpeed(speed: animationDuration / Float(selectedTimerDuration))
        delegate?.gameDidStart()
    }
    
    func pauseGame() {
        timer?.invalidate()
        tickAudioPlayer?.stop()
        let _ = animation?.pause()
        delegate?.gameDidPause()
    }
    
    func resumeGame() {
        startTimer()
        tickAudioPlayer?.play()
        let _ = animation?.play()
        delegate?.gameDidResume()
    }
    
    func exitGame() {
        timer?.invalidate()
        tickAudioPlayer?.stop()
        let _ = animation?.stop()
    }
    
    private func loadSound(name: String, player: inout AVAudioPlayer?) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Error loading sound: \(error)")
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    //    MARK: - Actions
    @objc private func updateTimer() {
        currentSeconds += 1
        delegate?.timerDidUpdate(seconds: currentSeconds)
        
        if currentSeconds >= selectedTimerDuration {
            timer?.invalidate()
            tickAudioPlayer?.stop()
            audioPlayer?.play()
            delegate?.gameDidEnd()
        }
    }
}
