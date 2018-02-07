//
//  QuestionBank.swift
//  Quizzler
//
//  Created by Ken Krippeler on 05.02.18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class QuestionBank
{
    var list = [Question]()
    
    init()
    {
        list.append(Question(text: "Riku is the main character of Kingdom Hearts 1.", correctAnswer: false, image: "Kingdom Key"))
        list.append(Question(text: "Naminé is Sora\'s and Riku\'s friend from Destiny Islands.", correctAnswer: false, image: "Kingdom Icon"))
        list.append(Question(text: "The Organization XIII is the antagonist of Kingdom Hearts 2.", correctAnswer: true, image: "Symbol_Nobody"))
        list.append(Question(text: "Kingdom Hearts 1 begins on the Destiny Islands.", correctAnswer: false, image: "Kingdom Icon"))
        list.append(Question(text: "Kairi is a princess of heart.", correctAnswer: true, image: "Kingdom Icon"))
        list.append(Question(text: "There are eighteen worlds in Kingdom Hearts Birth By Sleep.", correctAnswer: true, image: "Keyhole2"))
        list.append(Question(text: "Xehanort is a keyblade master.", correctAnswer: true, image: "Keyblade Master"))
        list.append(Question(text: "In Kingdom Hearts Birth By Sleep Ventus surcumbs to darkness.", correctAnswer: false, image: "Keyblade Master"))
        list.append(Question(text: "In Kingdom Hearts Dream Drop Distance Sora meets Ventus.", correctAnswer: false, image: "Keyblade Master"))
        list.append(Question(text: "In Kingdom Hearts Re: Coded Sora meets Roxas.", correctAnswer: true, image: "Symbol_Nobody"))
        list.append(Question(text: "Sora passes the mastery exam in Dream Drop Distance.", correctAnswer: false, image: "Keyblade Master"))
        list.append(Question(text: "Young Xehanort has control over time.", correctAnswer: true, image: "YX Key"))
        list.append(Question(text: "There have to be thirteen darknesses and seven pure lights to forge the \u{03C7}-Blade.", correctAnswer: true, image: "X"))
    }
}
