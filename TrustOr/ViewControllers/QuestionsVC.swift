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
    @IBOutlet weak var bottomButton: MyButton!
    @IBOutlet weak var topButton: MyButton!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var constraintFromQuestion: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    
    var game: Game!
    var startVC: StartVC!
    
    
    //MARK:- Buttons Actions
    @IBAction func topButtonPressed(_ sender: Any) {
        switch game.type! {
        case .singleGame:
            game.single.answerButtonPressed(button: true)
        case .crowdGame:
            game.crowd.laterButtonPressed()
        }
    }
    @IBAction func bottomButtonPressed(_ sender: Any) {
        switch game.type! {
        case .singleGame:
            switch game.single.answerState {
            case .answered: game.single.nextQuestionButtonPressed()
            case .notAnswered: game.single.answerButtonPressed(button: false)
            case .gotResults: game.single.finishGameButtonPressed()
            }
        case .crowdGame:
            switch game.crowd.answerState {
            case .answered: game.crowd.nextQuestionButtonPressed()
            case .notAnswered: game.crowd.showAnswerButtonPressed()
            default: break
            }
        }
    }
    //MARK:-
    private func setFonts() {
        let resultLabelFontSize = K.useSmallerFonts ? K.Fonts.Size.ResultLabel.zoomed : K.Fonts.Size.ResultLabel.normal
        resultLabel.font = .systemFont(ofSize: resultLabelFontSize, weight: .bold)
    }
    
    // MARK:- Override class func
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.setBackgroundImage(named: game.questionsPack.picname, alpha: K.Alpha.Background.questions)
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        view.makeAllButtonsRound()
        setFonts()
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 5.0
        shadowView.layer.masksToBounds = false
        shadowView.layer.cornerRadius = K.cornerRadius
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.started = true
        switch game.type! {
        case .singleGame:
            game.single.delegate = self
            game.single.show()
        case .crowdGame:
            game.crowd.delegate = self
            game.crowd.show()
        }
        /* Save startVC obj to return it back to nav stack later after removal
        if 0th obj is not startVC than it's already been removed and
        we already have saved it */
        if let startVC = navigationController?.viewControllers[0] as? StartVC {
            self.startVC = startVC
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
        } else if segue.identifier == "backToStart" {
            let chooseYearVC = segue.destination as! ChooseYearVC
            if let startVC = startVC {
                chooseYearVC.startVC = startVC
            }
        }
    }
}
