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
    func addTaps(forSingle singleTapAction: Selector?, forDouble doubleTapAction: Selector?, forTriple tripleTapAction: Selector?, forQuadriple quadripleTapAction: Selector?) {
        
        var singleTap: UITapGestureRecognizer!
        var doubleTap: UITapGestureRecognizer!
        var tripleTap: UITapGestureRecognizer!
        var quadripleTap: UITapGestureRecognizer!
        
        if let singleTapAction = singleTapAction {
            singleTap = UITapGestureRecognizer(target: self, action: singleTapAction)
            singleTap.numberOfTapsRequired = 1
        }
        if let doubleTapAction = doubleTapAction {
            doubleTap = UITapGestureRecognizer(target: self, action: doubleTapAction)
            doubleTap.numberOfTapsRequired = 2
        }
        if let tripleTapAction = tripleTapAction {
            tripleTap = UITapGestureRecognizer(target: self, action: tripleTapAction)
            tripleTap.numberOfTapsRequired = 3
        }
        if let quadripleTapAction = quadripleTapAction {
            quadripleTap = UITapGestureRecognizer(target: self, action: quadripleTapAction)
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
        
        if let singleTap = singleTap { self.view.addGestureRecognizer(singleTap) }
        if let doubleTap = doubleTap { self.view.addGestureRecognizer(doubleTap) }
        if let tripleTap = tripleTap { self.view.addGestureRecognizer(tripleTap) }
        if let quadripleTap = quadripleTap { self.view.addGestureRecognizer(quadripleTap) }
        
        self.view.isUserInteractionEnabled = true
    }
    
    func addTaps(forSingle singleTapAction: Selector) {
        var singleTap: UITapGestureRecognizer!
        singleTap = UITapGestureRecognizer(target: self, action: singleTapAction)
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        self.view.isUserInteractionEnabled = true
    }
}
