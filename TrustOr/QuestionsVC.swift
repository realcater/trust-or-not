//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    
    @IBOutlet weak var helpButton: MyButton!
    @IBOutlet weak var topButton: MyButton!
    @IBOutlet weak var bottomButton: MyButton!
    @IBOutlet weak var middleButton: MyButton!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var game: Game!
    
    //MARK:- Buttons Actions
    @IBAction func topButtonPressed(_ sender: Any) {
        game.single.answerButtonPressed(button: .trueAnswer)
    }
    
    @IBAction func middleButtonPressed(_ sender: Any) {
        switch game.type! {
        case .singleGame:
            game.single.answerButtonPressed(button: .doubtAnswer)
        case .crowdGame:
            game.crowd.laterButtonPressed()
        }
    }
    @IBAction func bottomButtonPressed(_ sender: Any) {
        switch game.type! {
        case .singleGame:
            switch game.single.answerState {
            case .answered: game.single.nextQuestionButtonPressed()
            case .notAnswered: game.single.answerButtonPressed(button: .falseAnswer)
            case .gotResults: game.single.finishGameButtonPressed()
            }
        case .crowdGame:
            switch game.crowd.state.answerState {
            case .answered: game.crowd.nextQuestionButtonPressed()
            case .notAnswered: game.crowd.showAnswerButtonPressed()
            case .finishGame: game.crowd.finishGameButtonPressed()
            }
        }
    }
    //MARK:-
    private func setFonts() {
        let textViewFontSize = useSmallerFonts() ? K.Fonts.Size.TextView.zoomed : K.Fonts.Size.TextView.normal
        let resultLabelFontSize = useSmallerFonts() ? K.Fonts.Size.ResultLabel.zoomed : K.Fonts.Size.ResultLabel.normal
        questionText.font = .systemFont(ofSize: textViewFontSize)
        commentText.font = .italicSystemFont(ofSize: textViewFontSize)
        resultLabel.font = .systemFont(ofSize: resultLabelFontSize, weight: .bold)
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: game.questionsPack.picname, alpha: K.Alpha.Background.questions)
        view.makeAllButtonsRound()
        setFonts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.started = true
        switch game.type! {
        case .singleGame:
            game.single.delegate = self
            game.single.show()
        case .crowdGame:
            game.crowd = CrowdGame(delegate: self, questionsPack: game.questionsPack, state: CrowdGameState(), questionText: questionText, commentText: commentText, showAnswerButton: bottomButton, nextQuestionButton: bottomButton, laterButton: middleButton, finishGameButton: bottomButton, helpButton: helpButton, resultLabel: resultLabel)
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
            helpVC.pagesForLoad = K.helpPages[game.type]!
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

