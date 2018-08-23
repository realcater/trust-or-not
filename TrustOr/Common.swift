//
//  Common.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit
import AVFoundation

typealias noArgsFuncOpt = (() -> Void)?
typealias noArgsFunc = () -> Void

func makeRoundedColorButton(for button: UIButton) {
    button.backgroundColor = K.activeButtonColor
    button.setTitleColor(K.backgroundColor, for: .normal)
    button.layer.cornerRadius = 0.5 * button.bounds.size.height
}

func makeRoundedGrayButton(for button: UIButton) {
    button.backgroundColor = K.grayColor
    button.setTitleColor(K.backgroundColor, for: .normal)
    button.layer.cornerRadius = 0.5 * button.bounds.size.height
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
            if finished, rollsFinished == rollsQty { //block with i==0 finishes last of all i=..
                action()
            }
        })
        duration = duration / acceleration
    }
}

func multiTransition(with view: UIView, duration : Double, options: UIView.AnimationOptions, animations: noArgsFuncOpt, times: Int) {
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

func addTaps(for viewController: UIViewController, forSingle singleTapAction: Selector?, forDouble doubleTapAction: Selector?, forTriple tripleTapAction: Selector?, forQuadriple quadripleTapAction: Selector?) {
    
    var singleTap: UITapGestureRecognizer!
    var doubleTap: UITapGestureRecognizer!
    var tripleTap: UITapGestureRecognizer!
    var quadripleTap: UITapGestureRecognizer!
    
    if let singleTapAction = singleTapAction {
        singleTap = UITapGestureRecognizer(target: viewController, action: singleTapAction)
        singleTap.numberOfTapsRequired = 1
    }
    if let doubleTapAction = doubleTapAction {
        doubleTap = UITapGestureRecognizer(target: viewController, action: doubleTapAction)
        doubleTap.numberOfTapsRequired = 2
    }
    if let tripleTapAction = tripleTapAction {
        tripleTap = UITapGestureRecognizer(target: viewController, action: tripleTapAction)
        tripleTap.numberOfTapsRequired = 3
    }
    if let quadripleTapAction = quadripleTapAction {
        quadripleTap = UITapGestureRecognizer(target: viewController, action: quadripleTapAction)
        quadripleTap.numberOfTapsRequired = 4
    }
    if let singleTap = singleTap, let doubleTap = doubleTap  {
        singleTap.require(toFail: doubleTap)
    }
    if let singleTap = singleTap, let tripleTap = tripleTap {
        singleTap.require(toFail: tripleTap)
    }
    if let singleTap = singleTap, let quadripleTap = quadripleTap {
        singleTap.require(toFail: quadripleTap)
    }
    
    if let doubleTap = doubleTap, let tripleTap = tripleTap  {
        doubleTap.require(toFail: tripleTap)
    }
    if let doubleTap = doubleTap, let quadripleTap = quadripleTap  {
        doubleTap.require(toFail: quadripleTap)
    }
    if let tripleTap = tripleTap , let quadripleTap = quadripleTap  {
        tripleTap.require(toFail: quadripleTap)
    }
    
    if let singleTap = singleTap { viewController.view.addGestureRecognizer(singleTap) }
    if let doubleTap = doubleTap { viewController.view.addGestureRecognizer(doubleTap) }
    if let tripleTap = tripleTap { viewController.view.addGestureRecognizer(tripleTap) }
    if let quadripleTap = quadripleTap { viewController.view.addGestureRecognizer(quadripleTap) }
    
    viewController.view.isUserInteractionEnabled = true
}

func initSound(mp3filename: String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: "ratchel.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        return player
    } catch {
        print("couldn't load file \(mp3filename)")
        return nil
    }
}
func initSound2(mp3filename: String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: "ding.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        return player
    } catch {
        print("couldn't load file \(mp3filename)")
        return nil
    }
}
