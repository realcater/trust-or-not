//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 14.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class StartGameView: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var animalButton: UIButton!
    @IBAction func pressAnimalButton(_ sender: Any) {
        print(animalButton.tintColor)
        
    }
    
    var animal : Animal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        makeRoundedColorButton(for: startButton)
        
        animalButton.tintColor = K.foregroundColor
        animalButton.backgroundColor = K.backgroundColor
        animalButton.setImage(UIImage(named: animal.picname), for: .normal)
        animalButton.contentHorizontalAlignment = .fill
        animalButton.contentVerticalAlignment = .fill
        
        title = K.confirmAnimalChoiceText1 + animal.name_gen + K.confirmAnimalChoiceText2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameViaAnimalButton" || segue.identifier == "startGameViaPlayButton" {
            let questionsView = segue.destination as! QuestionsView
            questionsView.animal = animal
        }
    }
}
