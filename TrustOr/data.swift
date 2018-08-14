//
//  ViewController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 13.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//
/*
import UIKit

class chooseYearView: UIViewController {
    
    struct animal_type {
        var name_gen : String
        var picname : String
        var num : Int
    }
    let mainColor = UIColor.red
    
    let a = [ animal_type(name_gen: "крысы", picname:"1",num:1) ]
    let AnimalsNums: CountableClosedRange = 0...11
    let pics = ["01-rat","02-ox","03-tiger","04-rabbit","05-dragon","06-snake","07-horse","08-ram","09-monkey","10-rooster","11-dog","12-pig"]
    
    func tileButtons() {
        let columnsQty = 3
        let rowsQty = 4
        let marginX: CGFloat = 0
        let marginTop: CGFloat = 72
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
            //button.addTarget(self, action: #selector(buttonPressed),
            //                 for: .touchUpInside)
            button.frame = CGRect(x: marginX + CGFloat(col)*(itemWidth+distX),
                                  y: marginTop + CGFloat(row)*(itemHeight+distY),
                                  width: itemWidth, height: itemHeight)
            button.setImage(UIImage(named: String(i+1)),
                            for: .normal)
            //button.tintColor = mainColor
            view.addSubview(button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title1.tintColor = mainColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
*/
