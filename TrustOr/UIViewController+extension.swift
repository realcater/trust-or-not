//
//  UIViewController+extension.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 31.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

typealias noArgsFuncOpt = (() -> Void)?
typealias noArgsFunc = () -> Void

extension UIViewController {
    func addTaps(for tappedView: UIView, singleTapAction: Selector?,doubleTapAction: Selector?) {
        
        var singleTap: UITapGestureRecognizer!
        var doubleTap: UITapGestureRecognizer!
        
        if let singleTapAction = singleTapAction {
            singleTap = UITapGestureRecognizer(target: self, action: singleTapAction)
            singleTap.numberOfTapsRequired = 1
        }
        if let doubleTapAction = doubleTapAction {
            doubleTap = UITapGestureRecognizer(target: self, action: doubleTapAction)
            doubleTap.numberOfTapsRequired = 2
        }
        
        if let singleTap = singleTap, let doubleTap = doubleTap  {
            singleTap.require(toFail: doubleTap)
        }
        
        if let singleTap = singleTap { tappedView.addGestureRecognizer(singleTap) }
        if let doubleTap = doubleTap { tappedView.addGestureRecognizer(doubleTap) }
        
        tappedView.isUserInteractionEnabled = true
    }
}
