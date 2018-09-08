//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    
    @IBOutlet weak var helpButton: UIButton!
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
        let textViewFontSize = useSmallerFonts() ? K.Fonts.Size.TextView.zoomed : K.Fonts.Size.TextView.normal
        let resultLabelFontSize = useSmallerFonts() ? K.Fonts.Size.ResultLabel.zoomed : K.Fonts.Size.ResultLabel.normal
        questionText.font = .systemFont(ofSize: textViewFontSize)
        commentText.font = .italicSystemFont(ofSize: textViewFontSize)
        resultLabel.font = .systemFont(ofSize: resultLabelFontSize, weight: .bold)
    }
    private func prepareButtons() {
        bottomButton.makeRounded(color: K.Colors.Buttons.trueAnswer, textColor: K.Colors.background)
        middleButton.makeRounded(color: K.Colors.Buttons.doubtAnswer, textColor: K.Colors.background, sound: K.Sounds.click)
        topButton.makeRounded(color: K.Colors.Buttons.falseAnswer
, textColor: K.Colors.background)
        bottomButton.isHidden = true
        middleButton.isHidden = true
        topButton.isHidden = true
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: questionsPack.picname, alpha: K.Alpha.Background.questions)
        prepareButtons()
        setFonts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameState.started = true
        switch gameState.gameType! {
        case .singleGame:
            singleGame = SingleGame(delegate: self, questionsPack: questionsPack, state: gameState.singleGameState, questionText: questionText, commentText: commentText, trueAnswerButton: topButton, doubtAsnwerButton: middleButton, falseAsnwerButton: bottomButton, nextQuestionButton: bottomButton, finishGameButton: bottomButton, helpButton: helpButton, resultLabel: resultLabel)
        case .crowdGame:
            crowdGame = CrowdGame(delegate: self, questionsPack: questionsPack, state: gameState.crowdGameState, questionText: questionText, commentText: commentText, showAnswerButton: bottomButton, nextQuestionButton: bottomButton, laterButton: middleButton, finishGameButton: bottomButton, helpButton: helpButton, resultLabel: resultLabel)
        }
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            if let ViewControllersCount = navigationController?.viewControllers.count {
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! ChooseGameVC
                prevViewController.bottomButton.setTitle(K.Labels.Buttons.continueGame, for: .normal)
                prevViewController.topButton.isHidden = true
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHelp" {
            let helpVC = segue.destination as! HelpVC
            helpVC.pagesForLoad = K.helpPages[gameState.gameType]!
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
    func textScore(_ score: Int) -> String {
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
        navView.frame = CGRect(x: 0,y: 0, width: width-2*K.Margins.title, height: height)
        if let titleLabel = navView.viewWithTag(1000) as? UILabel {
            titleLabel.text = title
        }
        if let scoreLabel = navView.viewWithTag(1001) as? UILabel {
            scoreLabel.text = textScore(score)
        }
        navigationItem.titleView = navView
    }
}
