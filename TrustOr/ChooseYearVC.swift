//
//  ViewController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 13.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseYearVC: UIViewController {

    @objc func buttonPressed(_ sender: UIButton) {
        let chosenAnimal = questionsPacks.items[Int(sender.tag)-2000]
        if chosenAnimal.questionTasks.count > 0 {
            performSegue(withIdentifier: "yearChosen", sender: sender)
        }
    }
    var questionsPacks = ChineseAnimals()
    
    private func tileButtons() {
        var distX: CGFloat = 0
        var distY: CGFloat = 0
        let (viewWidth,viewHeight) = (view.bounds.size.width, view.bounds.size.height)
        
        var itemWidth = (viewWidth-2*K.AnimalButtons.marginX+distX)/CGFloat(K.AnimalButtons.columnsQty)-distX
        var itemHeight = (viewHeight-(K.AnimalButtons.marginTop+K.AnimalButtons.marginBottom)+distY)/CGFloat(K.AnimalButtons.rowsQty)-distY
        
        if itemWidth < itemHeight {
            itemHeight = itemWidth
            distY = (viewHeight-(K.AnimalButtons.marginTop+K.AnimalButtons.marginBottom)-CGFloat(K.AnimalButtons.rowsQty)*itemHeight)/(CGFloat(K.AnimalButtons.rowsQty)-1)
        } else {
            itemWidth = itemHeight
            distX = (viewWidth - 2*K.AnimalButtons.marginX-CGFloat(K.AnimalButtons.columnsQty)*itemWidth)/(CGFloat(K.AnimalButtons.columnsQty)-1)
        }
        
        for (i,animal) in questionsPacks.items.enumerated() {
            let col = i % K.AnimalButtons.columnsQty
            let row = i / K.AnimalButtons.columnsQty
            let button = UIButton(type: .system)
            button.tag = 2000 + i
            button.addTarget(self, action: #selector(buttonPressed),
                             for: .touchUpInside)
            button.frame = CGRect(x: K.AnimalButtons.marginX + CGFloat(col)*(itemWidth+distX),
                                  y: K.AnimalButtons.marginTop + CGFloat(row)*(itemHeight+distY),
                                  width: itemWidth, height: itemHeight)
            button.setImage(UIImage(named: animal.picname),
                                      for: .normal)
            button.tintColor = K.Colors.foreground
            if animal.questionTasks.count == 0 {
                button.isUserInteractionEnabled = false
                button.tintColor = K.Colors.Buttons.disabled
            }
            button.turnClickSoundOn(sound: K.Sounds.click)
            view.addSubview(button)
        }
    }
    
    private func prepareNavigationBar() {
        navigationController?.navigationBar.barTintColor = K.Colors.foreground
        navigationController?.navigationBar.tintColor = K.Colors.background
        navigationController?.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: K.Fonts.Size.naviBar, weight: .medium), NSMutableAttributedString.Key.foregroundColor :K.Colors.background]
        navigationController?.navigationBar.topItem?.title = K.Labels.Titles.chooseYear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Colors.background
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareNavigationBar()
        tileButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        questionsPacks = ChineseAnimals() //reinitiaiate all questions
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yearChosen" {
            let startGameView = segue.destination as! ChooseGameVC
            let animalNumber = (sender as! UIButton).tag - 2000
            startGameView.questionsPack = questionsPacks.items[animalNumber]
        }
    }
    
}

