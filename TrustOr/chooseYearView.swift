//
//  ViewController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 13.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseYearView: UIViewController {

    @IBOutlet weak var chooseYearLabel: UILabel!
    let AnimalsNums: CountableClosedRange = 0...11
    
    let foregroundColor = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
    let backgroundColor = UIColor.white
    
    @objc func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "BeginGame", sender: sender)
    }
    var animals = ChineseAnimals()
    
    func tileButtons() {
        let columnsQty = 3
        let rowsQty = 4
        let marginX: CGFloat = 0
        let marginTop: CGFloat = 88
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
            button.setImage(UIImage(named: String(i+1)),
                                      for: .normal)
            button.tintColor = foregroundColor
            view.addSubview(button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseYearLabel.textColor = backgroundColor
        chooseYearLabel.backgroundColor = foregroundColor
        view.backgroundColor = backgroundColor
        tileButtons()
        print(animals.items[0].name_gen)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "BeginGame" {
            let questionsView = segue.destination as! QuestionsView
            //questionsView.animal = Animals.animals[(sender as! UIButton).tag - 2000]
            }
    }
    
}

