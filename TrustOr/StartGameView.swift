//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 14.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class StartGameView: UIViewController {
    
    @IBOutlet weak var animalButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBAction func pressAnimalButton(_ sender: Any) {
    }
    @IBAction func pressBottomButton(_ sender: Any) {
    }
    var questionsPack: QuestionsPack!
    var gameState = GameState()
    
    private func prepareButtons() {
        makeRoundedButton(for: topButton, with: K.foregroundColor)
        topButton.setTitle(K.startSingleGameButtonText, for: .normal)
        
        makeRoundedButton(for: bottomButton, with: K.foregroundColor)
        bottomButton.setTitle(K.startCrowdGameButtonText, for: .normal)
        
        animalButton.tintColor = K.foregroundColor
        animalButton.backgroundColor = K.backgroundColor
        animalButton.setImage(UIImage(named: questionsPack.picname), for: .normal)
        animalButton.contentHorizontalAlignment = .fill
        animalButton.contentVerticalAlignment = .fill
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        prepareButtons()
        title = K.confirmAnimalChoiceText1 + questionsPack.name_gen + K.confirmAnimalChoiceText2
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !gameState.started {
            if segue.identifier == "topButtonSegue" {
                gameState.gameType = .singleGame
                gameState.singleGameState = SingleGameState()
            } else if segue.identifier == "bottomButtonSegue" {
                gameState.gameType = .crowdGame
                gameState.crowdGameState = CrowdGameState()
            }
        }
        let questionsView = segue.destination as! QuestionsView
        questionsView.questionsPack = questionsPack
        questionsView.gameState = gameState
    }
}
