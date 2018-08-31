//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    
    let fontSize = useSmallerFonts() ? K.fontSizeTextViewZoomed : K.fontSizeTextViewNormal 

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
            case .finishGame: singleGame.getResultsButtonPressed()
            case .gotResults: singleGame.finishGameButtonPressed()
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
    private func setFonts() {
        questionText.font = .systemFont(ofSize: fontSize)
        commentText.font = .italicSystemFont(ofSize: fontSize)
        resultLabel.font = .systemFont(ofSize: fontSize+3, weight: .bold)
    }
    private func prepareBackgroundImage() {
        if let image = UIImage(named: questionsPack.picname) {
            backgroundImageView.image = image
        }
        backgroundImageView.isHidden = false
        backgroundImageView.alpha = 0.03
    }
    private func prepareButtons() {
        bottomButton.makeRounded(color: K.trueAnswerButtonColor, textColor: K.backgroundColor)
        middleButton.makeRounded(color: K.doubtAnswerButtonColor, textColor: K.backgroundColor)
        topButton.makeRounded(color: K.falseAnswerButtonColor, textColor: K.backgroundColor)
        bottomButton.isHidden = true
        middleButton.isHidden = true
        topButton.isHidden = true
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareBackgroundImage()
        prepareButtons()
        setFonts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameState.started = true
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
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! ChooseGameVC
                prevViewController.bottomButton.setTitle(K.continueGameButtonText, for: .normal)
                prevViewController.topButton.isHidden = true
            }
        }
    }
}

extension QuestionsVC: CrowdGameDelegate {
    func returnToStartView() {
        performSegue(withIdentifier: "backToStart", sender: self)
    }
    func setTitle(title: String) {
        self.title = title
    }
}

extension QuestionsVC: SingleGameDelegate {
    private func textScore(_ score: Int) -> String {
        switch score {
        case 1...Int.max: return "+"+String(score)
        case 0: return ""+String(score)
        default: return String(score)
        }
    }
    func setScoreTitle(title: String, score: Int) {
        let navView = UINib(nibName: "navView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        let width = navigationController!.navigationBar.frame.width
        let height = navigationController!.navigationBar.frame.height
        navView.frame = CGRect(x: 0,y: 0, width: width-2*K.titleMargin, height: height)
        if let titleLabel = navView.viewWithTag(1000) as? UILabel {
            titleLabel.text = title
        }
        if let scoreLabel = navView.viewWithTag(1001) as? UILabel {
            scoreLabel.text = textScore(score)
        }
        navigationItem.titleView = navView
    }
}
