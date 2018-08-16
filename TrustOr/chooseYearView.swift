//
//  ViewController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 13.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseYearView: UIViewController {

    let AnimalsNums: CountableClosedRange = 0...11
    
    @objc func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "BeginGame", sender: sender)
    }
    var animals = ChineseAnimals()
    
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
        
        for i in AnimalsNums {
            let col = i % columnsQty
            let row = i / columnsQty
            print(i,col,row)
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
            view.addSubview(button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //chooseYearLabel.textColor = K.backgroundColor
        //chooseYearLabel.backgroundColor = K.foregroundColor
        view.backgroundColor = K.backgroundColor
        navigationController?.navigationBar.barTintColor = K.foregroundColor
        navigationController?.navigationBar.tintColor = K.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24, weight: .medium), NSAttributedStringKey.foregroundColor :K.backgroundColor]
        navigationController?.navigationBar.topItem?.title = "Какой год играем?"
        tileButtons()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "BeginGame" || segue.identifier == "Nav" {
            let questionsView = segue.destination as! StartGameView
            let animalNumber = (sender as! UIButton).tag - 2000
            questionsView.animal = animals.items[animalNumber]
        }
    }
    
}

