//
//  ViewController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 13.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseYearView: UIViewController {

    @objc func buttonPressed(_ sender: UIButton) {
        let chosenAnimal = questionsPacks.items[Int(sender.tag)-2000]
        if chosenAnimal.questionTasks.count > 0 {
            performSegue(withIdentifier: "yearChosen", sender: sender)
        }
    }
    var questionsPacks = ChineseAnimals()
    
    func tileButtons() {
        let columnsQty = 3
        let rowsQty = 4
        let marginX: CGFloat = 0
        let marginTop: CGFloat = 75
        let marginBottom: CGFloat = 40
        var distX: CGFloat = 0
        var distY: CGFloat = 0
        let (viewWidth,viewHeight) = (view.bounds.size.width, view.bounds.size.height)
        
        var itemWidth = (viewWidth-2*marginX+distX)/CGFloat(columnsQty)-distX
        var itemHeight = (viewHeight-(marginTop+marginBottom)+distY)/CGFloat(rowsQty)-distY
        
        if itemWidth < itemHeight {
            itemHeight = itemWidth
            distY = (viewHeight-(marginTop+marginBottom)-CGFloat(rowsQty)*itemHeight)/(CGFloat(rowsQty)-1)
        } else {
            itemWidth = itemHeight
            distX = (viewWidth - 2*marginX-CGFloat(columnsQty)*itemWidth)/(CGFloat(columnsQty)-1)
        }
        
        for (i,animal) in questionsPacks.items.enumerated() {
            let col = i % columnsQty
            let row = i / columnsQty
            let button = UIButton(type: .system)
            button.tag = 2000 + i
            button.addTarget(self, action: #selector(buttonPressed),
                             for: .touchUpInside)
            button.frame = CGRect(x: marginX + CGFloat(col)*(itemWidth+distX),
                                  y: marginTop + CGFloat(row)*(itemHeight+distY),
                                  width: itemWidth, height: itemHeight)
            button.setImage(UIImage(named: String(i)),
                                      for: .normal)
            button.tintColor = K.foregroundColor
            if animal.questionTasks.count == 1 {
                button.isEnabled = false
            }
            view.addSubview(button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        navigationController?.navigationBar.barTintColor = K.foregroundColor
        navigationController?.navigationBar.tintColor = K.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedStringKey.foregroundColor :K.backgroundColor]
        navigationController?.navigationBar.topItem?.title = "Какой год играем?"
        tileButtons()
        print(UIScreen.main.currentMode!.size.width)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yearChosen" {
            let startGameView = segue.destination as! StartGameView
            let animalNumber = (sender as! UIButton).tag - 2000
            startGameView.questionsPack = questionsPacks.items[animalNumber]
        }
    }
    
}

