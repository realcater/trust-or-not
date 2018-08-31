//
//  UIButton+extension.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 30.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

extension UIButton {
    func makeRounded() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.height
    }
    func makeRounded(color: UIColor, textColor: UIColor) {
        self.backgroundColor = color
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = 0.5 * self.bounds.size.height
    }
}
