//
//  GameModel.swift
//  Game Bomb
//
//  Created by Александр Семёнов on 13.02.2025.
//


import UIKit
import AVFoundation
import DotLottie

final class FinalModel {
    // MARK: - Properties
    private let loss = MockData()
    
    private var timer: Timer?
    private var currentSeconds = 0
    private let secondsForGame = [10, 15, 20, 25, 30, 35, 40]
    private var selectedTimerDuration: Int = 0
    
    private var animation: DotLottieAnimation?
    private var animationView: UIView?
    private let animationDuration: Float = 7.65
    
    private var audioPlayer: AVAudioPlayer?
    private var tickAudioPlayer: AVAudioPlayer?
    
    // MARK: - Methods
    func exitGame() {
        timer?.invalidate()
        tickAudioPlayer?.stop()
        let _ = animation?.stop()
    }
    
    func prepeareLoss() -> String {
        let losses = loss.lossGame
        return losses.randomElement() ?? "Следущий раунд без наказания!"
    }
    
    private func setupAnimation() {
        guard URL(string: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie") != nil else { return }
        
        animation = DotLottieAnimation(webURL: "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie", config: AnimationConfig(autoplay: false, loop: false))
        animationView = animation?.view()
        animationView?.isHidden = false
    }
    
    private func prepareSounds() {
        loadSound(name: "soundBomb", player: &tickAudioPlayer)
        loadSound(name: "soundBoom", player: &audioPlayer)
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
}
