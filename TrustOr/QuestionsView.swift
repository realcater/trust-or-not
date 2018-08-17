//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsView: UIViewController {
    
    //MARK:- UIVars
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var finishGameButton: UIButton!
    
    @IBOutlet weak var trueView: UIView!
    @IBOutlet weak var falseView: UIView!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var commentText: UITextView!
    
    //MARK:- vars
    var animal : Animal!
    var currentQuestionNumber : Int = 0
    var leftQuestions : [Int] = []
    
    //MARK:- Private func
    private func showAnswer() {
        commentText.isHidden = false
        if animal.questionTasks[currentQuestionNumber].answer == true {
            trueView.isHidden = false
        } else {
            falseView.isHidden = false
        }
    }
    private func hideAnswer() {
        commentText.isHidden = true
        trueView.isHidden = true
        falseView.isHidden = true
    }
    private func reloadTexts() {
        questionText.text = animal.questionTasks[currentQuestionNumber].question
        commentText.text = animal.questionTasks[currentQuestionNumber].comment
        title = K.questionLabel + String(currentQuestionNumber+1)+"/"+String(animal.questionTasks.count)
        if leftQuestions.count > 0 {
            title = title! + "(+" + String(leftQuestions.count) + ")"
        }
    }
    private func showUIAnswerMode() {
        hideAnswer()
        showAnswerButton.isHidden = false
        laterButton.isHidden = false
        nextQuestionButton.isHidden = true
        reloadTexts()
    }
    private func showUIWaitMode() {
        showAnswer()
        showAnswerButton.isHidden = true
        laterButton.isHidden = true
        nextQuestionButton.isHidden = false
    }
    private func showUIFinishGame() {
        showAnswer()
        showAnswerButton.isHidden = true
        laterButton.isHidden = true
        finishGameButton.isHidden = false
    }
    private func oneMoreQueer() {
        var newQuestionTasks: [QuestionTask] = []
        for i in leftQuestions {
            newQuestionTasks.append(animal.questionTasks[i])
        }
        animal.questionTasks = newQuestionTasks
        leftQuestions = []
        currentQuestionNumber = 0
    }
    //MARK:- Buttons Actions
    @IBAction func showAnswerButtonPressed(_ sender: Any) {
        if (currentQuestionNumber+1 < animal.questionTasks.count) || (leftQuestions.count > 0) {
            showUIWaitMode()
        } else {
            showUIFinishGame()
        }
    }
    
    @IBAction func laterButtonPressed(_ sender: Any) {
        leftQuestions.append(currentQuestionNumber)
        currentQuestionNumber+=1
        if currentQuestionNumber == animal.questionTasks.count {
            oneMoreQueer()
        }
        reloadTexts()
    }
    
    @IBAction func nextQuestionButtonPressed(_ sender: Any) {
        currentQuestionNumber+=1
        if (currentQuestionNumber == animal.questionTasks.count) && (leftQuestions.count > 0) {
            oneMoreQueer()
        }
        showUIAnswerMode()
    }

    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        makeRoundedColorButton(for: showAnswerButton)
        makeRoundedColorButton(for: nextQuestionButton)
        makeRoundedGrayButton(for: laterButton)
        makeRoundedColorButton(for: finishGameButton)
        
        reloadTexts()
    }
}
