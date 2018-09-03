//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 14.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseGameVC: UIViewController {
    
    @IBOutlet weak var animalButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBAction func pressAnimalButton(_ sender: Any) {
    }
    @IBAction func pressBottomButton(_ sender: Any) {
    }
    var questionsPack: QuestionsPack!
    var gameState : GameState!
    
    private func prepareButtons() {
        topButton.makeRounded(color: K.Colors.foreground, textColor: K.Colors.background)
        topButton.setTitle(K.Labels.Buttons.startSingleGame, for: .normal)
        
        bottomButton.makeRounded(color: K.Colors.foreground, textColor: K.Colors.background)
        bottomButton.setTitle(K.Labels.Buttons.startCrowdGame, for: .normal)
        
        animalButton.tintColor = K.Colors.foreground
        animalButton.setImage(UIImage(named: questionsPack.picname), for: .normal)
        animalButton.contentHorizontalAlignment = .fill
        animalButton.contentVerticalAlignment = .fill
        animalButton.isUserInteractionEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Colors.background
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareButtons()
        gameState = GameState()
        title = K.Labels.Titles.ChooseGame.part1 + questionsPack.name_gen + K.Labels.Titles.ChooseGame.part2
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
        } else {
            print(gameState.gameType)
        }
        let questionsView = segue.destination as! QuestionsVC
        questionsView.questionsPack = questionsPack
        questionsView.gameState = gameState
    }
}
