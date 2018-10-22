//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 14.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseGameVC: UIViewController {
    
    @IBOutlet weak var animalButton: MyButton!
    @IBOutlet weak var topButton: MyButton!
    @IBOutlet weak var bottomButton: MyButton!
    @IBAction func pressAnimalButton(_ sender: Any) {
    }
    @IBAction func pressBottomButton(_ sender: Any) {
    }
    var game = Game()
    
    private func prepareButtons() {
        topButton.makeRounded(color: K.Colors.foreground, textColor: K.Colors.background, sound: K.Sounds.click)
        topButton.setTitle(K.Labels.Buttons.startSingleGame, for: .normal)
        
        bottomButton.makeRounded(color: K.Colors.foreground, textColor: K.Colors.background, sound: K.Sounds.click)
        bottomButton.setTitle(K.Labels.Buttons.startCrowdGame, for: .normal)
        
        animalButton.tintColor = K.Colors.foreground
        animalButton.setImage(UIImage(named: game.questionsPack.picname), for: .normal)
        animalButton.contentHorizontalAlignment = .fill
        animalButton.contentVerticalAlignment = .fill
        animalButton.isUserInteractionEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Colors.background
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareButtons()
        title = K.Labels.Titles.ChooseGame.part1 + game.questionsPack.name_gen + K.Labels.Titles.ChooseGame.part2
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !game.started {
            switch segue.identifier {
            case "topButtonSegue":
                game.type = .singleGame
                game.single = SingleGame(questionsPack: game.questionsPack)
            case "bottomButtonSegue":
                game.type = .crowdGame
                game.crowd = CrowdGame(questionsPack: game.questionsPack)
            default: break
            }
        }
        let questionsVC = segue.destination as! QuestionsVC
        questionsVC.game = game
    }
}
