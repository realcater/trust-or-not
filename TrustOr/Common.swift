//
//  Common.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

typealias noArgsFuncOpt = (() -> Void)?
typealias noArgsFunc = () -> Void
typealias tapFunc = (UITapGestureRecognizer) -> Void

func makeRoundedColorButton(for button: UIButton) {
    button.backgroundColor = K.activeButtonColor
    button.setTitleColor(K.backgroundColor, for: .normal)
    button.layer.cornerRadius = 0.5 * button.bounds.size.height
    //button.titleLabel?.font = UIFont(name: "Brushie Brushie", size: 25)
}

func makeRoundedGrayButton(for button: UIButton) {
    button.backgroundColor = K.grayColor
    button.setTitleColor(K.backgroundColor, for: .normal)
    button.layer.cornerRadius = 0.5 * button.bounds.size.height
    //button.titleLabel?.font = UIFont(name: "Brushie Brushie", size: 25)
}

func imageRotation(rotate imageView: UIImageView, for circlesQty:Double, onCompletion action: @escaping noArgsFunc) {
    let sectorsQty = 12.0
    let acceleration = 1.05
    var duration : Double = 5
    let rollsQty = Int(circlesQty*sectorsQty)
    var rollsFinished = 0
    for i in 0...rollsQty-1 {
        let angle = -CGFloat(i % Int(sectorsQty)+1)*CGFloat.pi*2.0/CGFloat(sectorsQty)
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: angle)
        }, completion: { finished in
            rollsFinished+=1
            print("i=\(i)")
            if finished, rollsFinished == rollsQty { //block with i==0 finishes last of all i=..
                action()
            }
        })
        duration = duration / acceleration
    }
}

func multiTransition(with view: UIView, duration : Double, options: UIViewAnimationOptions, animations: noArgsFuncOpt, times: Int) {
    UIView.transition(with: view,
                      duration: duration,
                      options: options,
                      animations: animations,
                      completion: {finished in
                        if finished, times > 1 {
                            multiTransition(with: view, duration: duration, options: options, animations: animations, times: times-1)
                        }
    })
}

func addTaps(for viewController: UIViewController, forDouble doubleTapAction: Selector, forTriple tripleTapAction: Selector, forQuadriple quadripleTapAction: Selector) {
    
    let doubleTap = UITapGestureRecognizer(target: viewController, action: doubleTapAction)
    doubleTap.numberOfTapsRequired = 2
    
    let tripleTap = UITapGestureRecognizer(target: viewController, action: tripleTapAction)
    tripleTap.numberOfTapsRequired = 3
    
    let quadripleTap = UITapGestureRecognizer(target: viewController, action: quadripleTapAction)
    quadripleTap.numberOfTapsRequired = 4
    
    doubleTap.require(toFail: tripleTap)
    doubleTap.require(toFail: quadripleTap)
    tripleTap.require(toFail: quadripleTap)
    
    viewController.view.addGestureRecognizer(doubleTap)
    viewController.view.addGestureRecognizer(tripleTap)
    viewController.view.addGestureRecognizer(quadripleTap)
    
    viewController.view.isUserInteractionEnabled = true
}

