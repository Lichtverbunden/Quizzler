//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var maxExpForLevelUpLabel: UILabel!
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var exp: Int = 0
    var currentLevel: Int = 1
    var levelMultiplier: Int = 1
    var maxExpForALevelUP: Int = 300
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let expEarned = UserDefaults.standard.object(forKey: "expEarned") as? Int
        {
            exp = expEarned
        }
        
        if let levelReached = UserDefaults.standard.object(forKey: "levelReached") as? Int
        {
            currentLevel = levelReached
        }
        
        if let lm = UserDefaults.standard.object(forKey: "lm") as? Int
        {
            levelMultiplier = lm
        }
        
        if let questionAnswered = UserDefaults.standard.object(forKey: "questionAnswered") as? Int
        {
            questionNumber = questionAnswered
        }
        
        if let maxLevel = UserDefaults.standard.object(forKey: "maxLevel") as? Int
        {
            maxExpForALevelUP = maxLevel
        }
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject)
    {
        if sender.tag == 1
        {
            pickedAnswer = true
        }
        else if sender.tag == 2
        {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber += 1
        UserDefaults.standard.set(questionNumber, forKey: "questionAnswered")
        nextQuestion()
    }
    
    
    func updateUI()
    {
        scoreLabel.text = "Exp earned: \(exp)"
        maxExpForLevelUpLabel.text = "/\(maxExpForALevelUP * levelMultiplier)"
        currentLevelLabel.text = "Current Level: \(currentLevel)"
        progressLabel.text = "\(questionNumber + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion()
    {
        if questionNumber <= 12
        {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            iconImageView.image = UIImage(named: allQuestions.list[questionNumber].image)
            
            updateUI()
        }
        else
        {
            let alert = UIAlertController(title: "Well done", message: "You've reached the end of the quiz and earned new experiences. Do you want to start over and make new ones? Your current experience points and level will remain until you press the Reset Exp and Level-Button.", preferredStyle: .actionSheet)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:
            { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer()
    {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer
        {
            ProgressHUD.showSuccess("Correct")
            
            if currentLevel < 99
            {
                exp += 70
                UserDefaults.standard.set(exp, forKey: "expEarned")
            }
            else
            {
                exp = 0
                UserDefaults.standard.set(exp, forKey: "expEarned")
                maxExpForALevelUP = 0
                UserDefaults.standard.set(maxExpForALevelUP, forKey: "maxLevel")
            }
        }
        else
        {
            ProgressHUD.showError("Wrong, but that makes you more experienced")
            
            if currentLevel < 98
            {
                exp += 75
                UserDefaults.standard.set(exp, forKey: "expEarned")
            }
            else
            {
                exp = 0
                UserDefaults.standard.set(exp, forKey: "expEarned")
                maxExpForALevelUP = 0
                UserDefaults.standard.set(maxExpForALevelUP, forKey: "maxLevel")
            }
        }
        
        if exp >= (maxExpForALevelUP * levelMultiplier)
        {
            if currentLevel < 98
            {
                currentLevel += 1
                levelMultiplier *= 2
                exp = 0
                UserDefaults.standard.set(currentLevel, forKey: "levelReached")
                UserDefaults.standard.set(levelMultiplier, forKey: "lm")
                UserDefaults.standard.set(exp, forKey: "expEarned")
            }
            else
            {
                currentLevel = 99
                UserDefaults.standard.set(currentLevel, forKey: "levelReached")
            }
        }
    }
    
    
    @IBAction func resetExpAndLevelPressed(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Reset Exp and Level", message: "Do you really want to reset your exp and level? This action is unreversable!", preferredStyle: .alert)
        
        let resetAction = UIAlertAction(title: "Reset", style: .default, handler:
        { (UIAlertAction) in
            self.exp = 0
            self.maxExpForALevelUP = 300
            self.levelMultiplier = 1
            self.currentLevel = 1
            UserDefaults.standard.set(self.exp, forKey: "expEarned")
            UserDefaults.standard.set(self.maxExpForALevelUP, forKey: "maxLevel")
            UserDefaults.standard.set(self.currentLevel, forKey: "levelReached")
            UserDefaults.standard.set(self.levelMultiplier, forKey: "lm")
            
            self.updateUI()
        })
        
        let resetAllAction = UIAlertAction(title: "Reset and Restart", style: .default, handler:
        { (UIAlertAction) in
            self.exp = 0
            self.maxExpForALevelUP = 300
            self.levelMultiplier = 1
            self.currentLevel = 1
            UserDefaults.standard.set(self.exp, forKey: "expEarned")
            UserDefaults.standard.set(self.maxExpForALevelUP, forKey: "maxLevel")
            UserDefaults.standard.set(self.currentLevel, forKey: "levelReached")
            UserDefaults.standard.set(self.levelMultiplier, forKey: "lm")
            
            self.startOver()
            self.updateUI()
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(resetAction)
        alert.addAction(resetAllAction)
        alert.addAction(cancelAction)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func startOver()
    {
        questionNumber = 0
        UserDefaults.standard.set(questionNumber, forKey: "questionAnswered")
        nextQuestion()
    }
    

    
}
