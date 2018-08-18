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
    var questionsPack : QuestionsPack!
    var state: QuestionsPackState!
    
    //MARK:- Private func
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
        title = K.questionLabel + String(state.currentNumber+1)+"/"+String(questionsPack.questionTasks.count)
        if state.leftQuestions.count > 0 {
            title = title! + "(+" + String(state.leftQuestions.count) + ")"
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
        for i in state.leftQuestions {
            newQuestionTasks.append(questionsPack.questionTasks[i])
        }
        questionsPack.questionTasks = newQuestionTasks
        state.leftQuestions = []
        state.currentNumber = 0
    }
    private func restoreQuestionAsnweredUI () {
        if (state.currentNumber+1 < questionsPack.questionTasks.count) || (state.leftQuestions.count > 0) {
            showUIWaitMode()
            //state.currentNumber+=1
        } else {
            showUIFinishGame()
        }
    }
    
    //MARK:- Buttons Actions
    @IBAction func showAnswerButtonPressed(_ sender: Any) {
        state.getAnswerForCurrent = true
        if (state.currentNumber+1 < questionsPack.questionTasks.count) || (state.leftQuestions.count > 0) {
            showUIWaitMode()
            
        } else {
            showUIFinishGame()
        }
    }
    
    @IBAction func laterButtonPressed(_ sender: Any) {
        state.leftQuestions.append(state.currentNumber)
        state.currentNumber+=1
        if state.currentNumber == questionsPack.questionTasks.count {
            oneMoreQueer()
        }
        reloadTexts()
    }
    
    @IBAction func nextQuestionButtonPressed(_ sender: Any) {
        state.currentNumber+=1
        if (state.currentNumber == questionsPack.questionTasks.count) && (state.leftQuestions.count > 0) {
            oneMoreQueer()
        }
        showUIAnswerMode()
        state.getAnswerForCurrent = false
    }

    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundedColorButton(for: showAnswerButton)
        makeRoundedColorButton(for: nextQuestionButton)
        makeRoundedGrayButton(for: laterButton)
        makeRoundedColorButton(for: finishGameButton)
        if UIScreen.main.currentMode!.size.width >= 750 {
            questionText.font = .systemFont(ofSize: K.fontSizeTextViewNormal)
            commentText.font = .italicSystemFont(ofSize: K.fontSizeTextViewNormal)
        } else {
            questionText.font = .systemFont(ofSize: K.fontSizeTextViewZoomed)
            commentText.font = .italicSystemFont(ofSize: K.fontSizeTextViewZoomed)
        }
        if state.getAnswerForCurrent {
            //state.currentNumber-=1
            restoreQuestionAsnweredUI()
        }
        reloadTexts()
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            if let ViewControllersCount = navigationController?.viewControllers.count {
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! StartGameView
                prevViewController.questionsPack = questionsPack
                prevViewController.state = state
                prevViewController.startButton.setTitle(K.textContinueButton, for: .normal)
            }
        }
    }
}
