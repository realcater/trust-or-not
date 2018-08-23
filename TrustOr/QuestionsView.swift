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
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var finishGameButton: UIButton!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var questionsPack: QuestionsPack!
    var crowdGame: CrowdGame!
    var state: QuestionsPackState!
    
    //MARK:- Buttons Actions
    @IBAction func topButtonPressed(_ sender: Any) {
        crowdGame.laterButtonPressed()
    }
    @IBAction func bottomButtonPressed(_ sender: Any) {
        switch crowdGame.state.answerState {
        case .answered: crowdGame.nextQuestionButtonPressed()
        case .notAnswered: crowdGame.showAnswerButtonPressed()
        case .finishGame: crowdGame.finishGameButtonPressed()
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
        makeRoundedColorButton(for: bottomButton)
        makeRoundedGrayButton(for: topButton)
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        crowdGame = CrowdGame(delegate: self, questionsPack: questionsPack, state: state, questionText: questionText, commentText: commentText, showAnswerButton: bottomButton, nextQuestionButton: bottomButton, laterButton: topButton, finishGameButton: bottomButton, resultLabel: resultLabel)
        prepareBackgroundImage()
        prepareButtons()
        if UIScreen.main.currentMode!.size.width >= 750 {
            setFonts(ofSize: K.fontSizeTextViewNormal)
        } else {
            setFonts(ofSize: K.fontSizeTextViewZoomed)
        }
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            if let ViewControllersCount = navigationController?.viewControllers.count {
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! StartGameView
                prevViewController.startButton.setTitle(K.continueGameButtonText, for: .normal)
            }
        }
    }
}

extension QuestionsView: CrowdGameDelegate {
    func returnToStartView() {
        performSegue(withIdentifier: "backToStart", sender: self)
    }
    func setTitle(title: String) {
        self.title = title
    }
}
