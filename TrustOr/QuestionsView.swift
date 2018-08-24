//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsView: UIViewController {
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var questionsPack: QuestionsPack!
    var crowdGame: CrowdGame!
    var singleGame: SingleGame!
    var gameState: GameState!
    
    //MARK:- Buttons Actions
    @IBAction func topButtonPressed(_ sender: Any) {
        singleGame.answerButtonPressed(button: .trueAnswer)
    }
    
    @IBAction func middleButtonPressed(_ sender: Any) {
        switch gameState.gameType! {
        case GameType.singleGame:
            singleGame.answerButtonPressed(button: .doubtAnswer)
        case GameType.crowdGame:
            crowdGame.laterButtonPressed()
        }
    }
    @IBAction func bottomButtonPressed(_ sender: Any) {
        switch gameState.gameType! {
        case GameType.singleGame:
            switch singleGame.state.answerState {
            case .answered: singleGame.nextQuestionButtonPressed()
            case .notAnswered: singleGame.answerButtonPressed(button: .falseAnswer)
            case .finishGame: singleGame.finishGameButtonPressed()
            }
        case GameType.crowdGame:
            switch crowdGame.state.answerState {
            case .answered: crowdGame.nextQuestionButtonPressed()
            case .notAnswered: crowdGame.showAnswerButtonPressed()
            case .finishGame: crowdGame.finishGameButtonPressed()
            }
        }
    }
    //MARK:- Prepare screen functions
    private func setFonts(ofSize size: CGFloat) {
        questionText.font = .systemFont(ofSize: size)
        commentText.font = .italicSystemFont(ofSize: size)
        resultLabel.font = .systemFont(ofSize: size+3, weight: .bold)
    }
    private func prepareBackgroundImage() {
        backgroundImageView.image = (UIImage(named: questionsPack.picname))
        backgroundImageView.isHidden = false
        backgroundImageView.alpha = 0.03
    }
    private func prepareButtons() {
        makeRoundedButton(for: bottomButton, with: K.foregroundColor)
        makeRoundedButton(for: middleButton, with: K.grayColor)
        makeRoundedButton(for: topButton, with: K.trueAnswerColor)
        bottomButton.isHidden = true
        middleButton.isHidden = true
        topButton.isHidden = true
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareBackgroundImage()
        prepareButtons()
        if UIScreen.main.currentMode!.size.width >= 750 {
            setFonts(ofSize: K.fontSizeTextViewNormal)
        } else {
            setFonts(ofSize: K.fontSizeTextViewZoomed)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch gameState.gameType! {
        case .singleGame:
            singleGame = SingleGame(delegate: self, questionsPack: questionsPack, state: gameState.singleGameState, questionText: questionText, commentText: commentText, trueAnswerButton: topButton, doubtAsnwerButton: middleButton, falseAsnwerButton: bottomButton, nextQuestionButton: bottomButton, finishGameButton: bottomButton, resultLabel: resultLabel)
        case .crowdGame:
            crowdGame = CrowdGame(delegate: self, questionsPack: questionsPack, state: gameState.crowdGameState, questionText: questionText, commentText: commentText, showAnswerButton: bottomButton, nextQuestionButton: bottomButton, laterButton: middleButton, finishGameButton: bottomButton, resultLabel: resultLabel)
        }
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            if let ViewControllersCount = navigationController?.viewControllers.count {
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! StartGameView
                prevViewController.topButton.setTitle(K.continueGameButtonText, for: .normal)
            }
        }
    }
}

extension QuestionsView: GameDelegate {
    func returnToStartView() {
        performSegue(withIdentifier: "backToStart", sender: self)
    }
    func setTitle(title: String) {
        self.title = title
    }
}
