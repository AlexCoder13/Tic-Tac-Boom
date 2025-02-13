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
    private let secondsForGame = [15, 20, 25, 30, 35, 40]
    private var selectedTimerDuration: Int = 0
    
    var animation: DotLottieAnimation?
    var animationView: UIView?
    private let animationDuration: Float = 7.9
    
    var audioPlayer: AVAudioPlayer?
    var tickAudioPlayer: AVAudioPlayer?
    
    // MARK: - Methods
    func setupAnimation() {
        guard URL(string: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie") != nil else { return }
        
        animation = DotLottieAnimation(webURL: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie", config: AnimationConfig(autoplay: false, loop: false))
        animationView = animation?.view()
        animationView?.isHidden = false
    }
    
    func prepareSounds() {
        loadSound(name: "soundBomb", player: &tickAudioPlayer)
        loadSound(name: "soundBoom", player: &audioPlayer)
    }
    
    func startGame() {
        selectedTimerDuration = secondsForGame.randomElement() ?? 30
        startTimer()
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
        let _ = animation?.play()
        delegate?.gameDidResume()
    }
    
    func exitGame() {
        timer?.invalidate()
        tickAudioPlayer?.stop()
        let _ = animation?.stop()
    }
    
    private func loadSound(name: String, player: inout AVAudioPlayer?) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
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
