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
            button.setImage(UIImage(named: animal.picname),
                                      for: .normal)
            button.tintColor = K.foregroundColor
            if animal.questionTasks.count == 0 {
                button.isEnabled = false
            }
            view.addSubview(button)
        }
    }
    @objc private func tripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            performSegue(withIdentifier: "backToIntro", sender: self)
        }
    }
    
    private func prepareNavigationBar() {
        navigationController?.navigationBar.barTintColor = K.foregroundColor
        navigationController?.navigationBar.tintColor = K.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSMutableAttributedString.Key.foregroundColor :K.backgroundColor]
        //navigationController?.navigationBar.titleTextAttributes = [NSMutableAttributedStringKey.font: UIFont(name: "Brushie Brushie", size: 30) ?? UIFont.systemFont(ofSize: 20, weight: .medium), NSMutableAttributedStringKey.foregroundColor :K.backgroundColor]
        navigationController?.navigationBar.topItem?.title = "Какой год играем?"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        prepareNavigationBar()
        tileButtons()
        self.addTaps(forSingle: nil, forDouble: #selector(tripleTap), forTriple: nil, forQuadriple: nil)
        //addTaps(for: self, forTriple: #selector(tripleTap))
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

