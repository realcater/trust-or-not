//
//  CrowdGame.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 23.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

<<<<<<< HEAD
=======
class QuestionsPackState {
    enum AnswerState {
        case notAnswered
        case answered
        case finishGame
    }
    var currentNumber: Int
    var leftQuestions: [Int]
    var answerState: AnswerState
    init() {
        currentNumber = 0
        leftQuestions = []
        answerState = .notAnswered
    }
}

>>>>>>> temp2
class CrowdGame {
    var questionText: UITextView
    var commentText: UITextView
    var showAnswerButton: UIButton
    var nextQuestionButton: UIButton
    var laterButton: UIButton
    var finishGameButton: UIButton
    var trueView: UIView
    var falseView: UIView
    var vc: UIViewController
    
    var questionsPack : QuestionsPack!
    var state: QuestionsPackState!
    
    init(questionsPack: QuestionsPack, state: QuestionsPackState, vc: UIViewController, questionText: UITextView, commentText: UITextView, showAnswerButton: UIButton, nextQuestionButton: UIButton, laterButton: UIButton, finishGameButton: UIButton, trueView: UIView, falseView: UIView) {
        self.questionsPack = questionsPack
        self.state = state
        self.vc = vc
        self.questionText = questionText
        self.commentText = commentText
        self.showAnswerButton = showAnswerButton
        self.nextQuestionButton = nextQuestionButton
        self.laterButton = laterButton
        self.finishGameButton = finishGameButton
        self.trueView = trueView
        self.falseView = falseView
<<<<<<< HEAD
        showUIAnswerMode()
    }
    
    func showAnswerButtonPressed() {
        state.getAnswerForCurrent = true
=======
        restoreState()
    }
    func restoreState() {
        switch state.answerState {
        case .answered: showUIWaitMode()
        case .finishGame: showUIFinishGame()
        case .notAnswered: showUIAnswerMode()
        }
        reloadTexts()
    }
    func showAnswerButtonPressed() {
        state.answerState = .answered
>>>>>>> temp2
        if (state.currentNumber+1 < questionsPack.questionTasks.count) || (state.leftQuestions.count > 0) {
            showUIWaitMode()
        } else {
            showUIFinishGame()
<<<<<<< HEAD
        }
    }
    
=======
            state.answerState = .finishGame
        }
    }
>>>>>>> temp2
    func laterButtonPressed() {
        state.leftQuestions.append(state.currentNumber)
        state.currentNumber+=1
        if state.currentNumber == questionsPack.questionTasks.count {
            oneMoreQueer()
        }
        reloadTexts()
    }
<<<<<<< HEAD
    
=======
>>>>>>> temp2
    func nextQuestionButtonPressed() {
        state.currentNumber+=1
        if (state.currentNumber == questionsPack.questionTasks.count) && (state.leftQuestions.count > 0) {
            oneMoreQueer()
        }
        showUIAnswerMode()
<<<<<<< HEAD
        state.getAnswerForCurrent = false
    }
    
=======
        state.answerState = .notAnswered
    }
    func finishGameButtonPressed() {
        vc.performSegue(withIdentifier: "backToStart", sender: vc)
    }
>>>>>>> temp2
    private func showAnswer() {
        commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.commentText.flashScrollIndicators()
        })
        if questionsPack.questionTasks[state.currentNumber].answer == true {
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
        questionText.text = questionsPack.questionTasks[state.currentNumber].question
        commentText.text = questionsPack.questionTasks[state.currentNumber].comment
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
        })
        vc.title = K.questionLabel + String(state.currentNumber+1)+"/"+String(questionsPack.questionTasks.count)
        if state.leftQuestions.count > 0 {
            vc.title = vc.title! + " (+" + String(state.leftQuestions.count) + ")"
        }
    }
    private func showUIAnswerMode() {
        hideAnswer()
        showAnswerButton.setTitle(K.showAnswerButtonText, for: .normal)
        laterButton.setTitle(K.laterButtonText, for: .normal)
        laterButton.isHidden = false
        reloadTexts()
    }
    private func showUIWaitMode() {
        showAnswer()
        laterButton.isHidden = true
        nextQuestionButton.setTitle(K.nextQuestionButtonText, for: .normal)
    }
    private func showUIFinishGame() {
        showAnswer()
        laterButton.isHidden = true
        finishGameButton.setTitle(K.finishGameButtonText, for: .normal)
<<<<<<< HEAD
=======
        
>>>>>>> temp2
    }
    private func oneMoreQueer() {
        var newQuestionTasks: [QuestionTask] = []
        for i in state.leftQuestions {
            newQuestionTasks.append(questionsPack.questionTasks[i])
        }
        questionsPack.questionTasks = newQuestionTasks
        state.leftQuestions = []
        state.currentNumber = 0
    }
    
<<<<<<< HEAD
    func checkAfterRestore() {
        if state.getAnswerForCurrent {
            restoreQuestionAsnweredUI()
        }
        reloadTexts()
    }
    
    private func restoreQuestionAsnweredUI () {
        if (state.currentNumber+1 < questionsPack.questionTasks.count) || (state.leftQuestions.count > 0) {
            showUIWaitMode()
            //state.currentNumber+=1
        } else {
            showUIFinishGame()
        }
    }
=======
>>>>>>> temp2
}
