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
    
    @IBOutlet weak var trueView: UIView!
    @IBOutlet weak var falseView: UIView!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var falsePicLabel: UILabel!
    @IBOutlet weak var falseTextLabel: UILabel!
    @IBOutlet weak var trueTextLabel: UILabel!
    @IBOutlet weak var truePicLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var questionsPack: QuestionsPack!
    var crowdGame: CrowdGame!
    var state: QuestionsPackState!
    
    //MARK:- Buttons Actions
    @IBAction func topButtonPressed(_ sender: Any) {
        crowdGame.laterButtonPressed()
    }
    @IBAction func bottomButtonPressed(_ sender: Any) {
        if crowdGame.state.getAnswerForCurrent {
            crowdGame.nextQuestionButtonPressed()
        } else {
            crowdGame.showAnswerButtonPressed()
        }
    }
    private func setFonts(ofSize size: CGFloat) {
        questionText.font = .systemFont(ofSize: size)
        commentText.font = .italicSystemFont(ofSize: size)
        truePicLabel.font = .systemFont(ofSize: size+12, weight: .black)
        falsePicLabel.font = .systemFont(ofSize: size-3)
        trueTextLabel.font = .systemFont(ofSize: size+3, weight: .bold)
        falseTextLabel.font = .systemFont(ofSize: size+3, weight: .bold)
    }
    private func prepareBackGroundImage() {
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
        crowdGame = CrowdGame(questionsPack: questionsPack, state: state, vc: self, questionText: questionText, commentText: commentText, showAnswerButton: bottomButton, nextQuestionButton: bottomButton, laterButton: topButton, finishGameButton: bottomButton, trueView: trueView, falseView: falseView)
        prepareBackGroundImage()
        prepareButtons()
        if UIScreen.main.currentMode!.size.width >= 750 {
            setFonts(ofSize: K.fontSizeTextViewNormal)
        } else {
            setFonts(ofSize: K.fontSizeTextViewZoomed)
        }
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            if let ViewControllersCount = navigationController?.viewControllers.count {
                let prevViewController = navigationController!.viewControllers[ViewControllersCount-1] as! StartGameView
                prevViewController.startButton.setTitle(K.continueGameButtonText, for: .normal)
            }
        }
    }
}
