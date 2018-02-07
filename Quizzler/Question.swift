//
//  Question.swift
//  Quizzler
//
//  Created by Ken Krippeler on 05.02.18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Question
{
    let questionText: String
    let answer: Bool
    let image: String
    
    init(text: String, correctAnswer: Bool, image: String)
    {
        self.questionText = text
        self.answer = correctAnswer
        self.image = image
    }
}
