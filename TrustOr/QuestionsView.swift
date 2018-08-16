//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 14.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsView: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var animalButton: UIButton!
    @IBAction func pressAnimalButton(_ sender: Any) {
        print(animalButton.tintColor)
        
    }
    
    var animal : Animal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        questionLabel.text = K.confirmAnimalChoiceText1 + animal.name_gen + K.confirmAnimalChoiceText2
        questionLabel.textColor = K.foregroundColor
        
        startButton.backgroundColor = K.foregroundColor
        startButton.setTitleColor(K.backgroundColor, for: .normal)
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.height
        
        animalButton.tintColor = K.foregroundColor
        animalButton.backgroundColor = K.backgroundColor
        animalButton.setImage(UIImage(named: animal.picname), for: .normal)
        animalButton.contentHorizontalAlignment = .fill
        animalButton.contentVerticalAlignment = .fill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
