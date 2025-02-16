//
//  Constatnts.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 14.02.2025.
//

import UIKit

struct K {
    static let rules =  [
        ("Все игроки становятся в круг.", nil),
        ("Первый игрок берет телефон и нажимает кнопку:", UIImage.CustomImage.startButton),
        ("На экране появляется вопрос “Назовите Фрукт”.", nil),
        ("Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку.", nil),
        ("Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.", nil),
        ("Проигравшим считается тот, в чьих руках взорвалась бомба.", nil),
        ("Если выбран режим игры “С Заданиями”, то проигравший выполняет задание.", nil)
    ]
    
    static let firstTitle = "ИГРА ДЛЯ КОМПАНИИ"
    static let secondTitle = "БОМБА"
    static let startTitle = "Старт игры"
    static let categoryTitle = "Категории"
    static let rulesTitle = "Правила игры"
    static let gameTitle = "Игра"
    static let questionTitle = "Нажмите 'Запустить' чтобы начать игру"
    static let startButtonTitle = "Запустить"
    static let endGameTitle = "Конец игры"
    static let restartGameTitle = "Начать заново"
    static let loseTitle = "Другое наказание"
    
    enum Player {
        static let pause = "pause.circle"
        static let play = "play.circle"
    }
}

struct LottieConstant {
    static let url = "https://lottie.host/283b3c79-ebb6-4439-a235-5b54cc15f7ad/zlrIDXcPgo.lottie"
}


