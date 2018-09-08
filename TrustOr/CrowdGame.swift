//
//  CrowdGame.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 23.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit


class CrowdGameState {
    enum AnswerState {
        case notAnswered
        case answered
        case finishGame
    }
    
    var currentNumber: Int
    var leftQuestions: [Int]
    var answerState: AnswerState
    var showHelp: Bool
    init() {
        currentNumber = 0
        leftQuestions = []
        answerState = .notAnswered
        showHelp = true
    }
}

protocol CrowdGameDelegate: class {
    func returnToStartView()
    func setTitle(title: String)
}

class CrowdGame {
    var questionText: UITextView
    var commentText: UITextView
    var showAnswerButton: MyButton
    var nextQuestionButton: MyButton
    var laterButton: MyButton
    var finishGameButton: MyButton
    var helpButton: MyButton
    var resultLabel: UILabel
    
    var questionsPack : QuestionsPack!
    var state: CrowdGameState!
    weak var delegate: CrowdGameDelegate?
    
    init(delegate: CrowdGameDelegate, questionsPack: QuestionsPack, state: CrowdGameState, questionText: UITextView, commentText: UITextView, showAnswerButton: MyButton, nextQuestionButton: MyButton, laterButton: MyButton, finishGameButton: MyButton, helpButton: MyButton, resultLabel: UILabel) {
        self.delegate = delegate
        self.questionsPack = questionsPack
        self.state = state
        self.questionText = questionText
        self.commentText = commentText
        self.showAnswerButton = showAnswerButton
        self.nextQuestionButton = nextQuestionButton
        self.laterButton = laterButton
        self.finishGameButton = finishGameButton
        self.helpButton = helpButton
        self.resultLabel = resultLabel
        restoreState()
        self.laterButton.turnClickSoundOn(sound: K.Sounds.click)
        
        
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
        if state.currentNumber == K.maxHelpShowedQty {
            state.showHelp = false
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delay.flashScrollIndicators, execute: {
            self.questionText.flashScrollIndicators()
        })
        var title = K.Labels.Titles.question + String(state.currentNumber+1)+"/"+String(questionsPack.questionTasks.count)
        if state.leftQuestions.count > 0 {
            title = title + " (+" + String(state.leftQuestions.count) + ")"
        }
        delegate?.setTitle(title: title)
    }
    private func showAnswer() {
        commentText.text = questionsPack.questionTasks[state.currentNumber].comment
        //commentText.superview!.setConstraint(identifier: "commentTextBottom", size: 10)
        //commentText.textColor = .black
        commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delay.flashScrollIndicators, execute: {
            self.commentText.flashScrollIndicators()
        })
        if questionsPack.questionTasks[state.currentNumber].answer == true {
            resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
            resultLabel.text = K.Labels.ResultBar.True.neutral
            K.Sounds.correct?.play()
        } else {
            resultLabel.backgroundColor = K.Colors.ResultBar.falseAnswer
            resultLabel.text = K.Labels.ResultBar.False.neutral
            K.Sounds.error?.play()
        }
        resultLabel.isHidden = false
    }
    private func hideAnswer() {
        commentText.isHidden = true
        resultLabel.isHidden = true
    }
    private func showUIAnswerMode() {
        hideAnswer()
        if state.showHelp { helpButton.isHidden = false }
        showAnswerButton.setTitle(K.Labels.Buttons.showAnswer, for: .normal)
        showAnswerButton.backgroundColor = K.Colors.foreground
        showAnswerButton.isHidden = false
        showAnswerButton.sound = nil
        laterButton.setTitle(K.Labels.Buttons.later, for: .normal)
        laterButton.backgroundColor = K.Colors.gray
        laterButton.isHidden = false
        reloadTexts()
    }
    private func showUIWaitMode() {
        helpButton.isHidden = true
        showAnswer()
        laterButton.isHidden = true
        nextQuestionButton.setTitle(K.Labels.Buttons.nextQuestion, for: .normal)
        nextQuestionButton.turnClickSoundOn(sound: K.Sounds.page)
    }
    private func showUIFinishGame() {
        helpButton.isHidden = true
        showAnswer()
        laterButton.isHidden = true
        finishGameButton.setTitle(K.Labels.Buttons.finishGame, for: .normal)
        finishGameButton.turnClickSoundOn(sound: K.Sounds.click)
        K.Sounds.applause?.play()
    }
    
}
