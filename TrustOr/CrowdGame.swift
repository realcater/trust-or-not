//
//  CrowdGame.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 23.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

enum AnswerState {
    case notAnswered
    case answered
    case finishGame
}

class QuestionsPackState {
    var currentNumber: Int
    var leftQuestions: [Int]
    var answerState: AnswerState
    init() {
        currentNumber = 0
        leftQuestions = []
        answerState = .notAnswered
    }
}

protocol CrowdGameDelegate: class {
    func returnToStartView()
    func setTitle(title: String)
}

class CrowdGame {
    var questionText: UITextView
    var commentText: UITextView
    var showAnswerButton: UIButton
    var nextQuestionButton: UIButton
    var laterButton: UIButton
    var finishGameButton: UIButton
    var resultLabel: UILabel
    
    var questionsPack : QuestionsPack!
    var state: QuestionsPackState!
    weak var delegate: CrowdGameDelegate?
    
    init(delegate: CrowdGameDelegate, questionsPack: QuestionsPack, state: QuestionsPackState, questionText: UITextView, commentText: UITextView, showAnswerButton: UIButton, nextQuestionButton: UIButton, laterButton: UIButton, finishGameButton: UIButton, resultLabel: UILabel) {
        self.delegate = delegate
        self.questionsPack = questionsPack
        self.state = state
        self.questionText = questionText
        self.commentText = commentText
        self.showAnswerButton = showAnswerButton
        self.nextQuestionButton = nextQuestionButton
        self.laterButton = laterButton
        self.finishGameButton = finishGameButton
        self.resultLabel = resultLabel
        restoreState()
    }
    
    //MARK:- Game logic = Data change functions
    func showAnswerButtonPressed() {
        state.answerState = .answered
        if (state.currentNumber+1 < questionsPack.questionTasks.count) || (state.leftQuestions.count > 0) {
            showUIWaitMode()
        } else {
            state.answerState = .finishGame
            showUIFinishGame()
        }
    }
    func laterButtonPressed() {
        state.leftQuestions.append(state.currentNumber)
        state.currentNumber+=1
        if state.currentNumber == questionsPack.questionTasks.count {
            oneMoreQueer()
        }
        reloadTexts()
    }
    func nextQuestionButtonPressed() {
        state.currentNumber+=1
        if (state.currentNumber == questionsPack.questionTasks.count) && (state.leftQuestions.count > 0) {
            oneMoreQueer()
        }
        showUIAnswerMode()
        state.answerState = .notAnswered
    }
    func finishGameButtonPressed() {
        delegate?.returnToStartView()
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
    //MARK:- UI Change functions
    func restoreState() {
        switch state.answerState {
        case .answered: showUIWaitMode()
        case .finishGame: showUIFinishGame()
        case .notAnswered: showUIAnswerMode()
        }
        reloadTexts()
    }
    private func reloadTexts() {
        questionText.text = questionsPack.questionTasks[state.currentNumber].question
        commentText.text = questionsPack.questionTasks[state.currentNumber].comment
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
        })
        var title = K.questionLabel + String(state.currentNumber+1)+"/"+String(questionsPack.questionTasks.count)
        if state.leftQuestions.count > 0 {
            title = title + " (+" + String(state.leftQuestions.count) + ")"
        }
        delegate?.setTitle(title: title)
    }
    private func showAnswer() {
        commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.commentText.flashScrollIndicators()
        })
        if questionsPack.questionTasks[state.currentNumber].answer == true {
            //trueView.isHidden = false
            resultLabel.backgroundColor = K.trueAnswerColor
            resultLabel.text = K.trueText
        } else {
            resultLabel.backgroundColor = K.falseAnswerColor
            resultLabel.text = K.falseText
            //falseView.isHidden = false
        }
        resultLabel.isHidden = false
    }
    private func hideAnswer() {
        commentText.isHidden = true
        //trueView.isHidden = true
        //falseView.isHidden = true
        resultLabel.isHidden = true
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
    }
    
}
