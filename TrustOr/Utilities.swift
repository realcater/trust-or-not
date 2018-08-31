//
//  Common.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

func + (left: NSMutableAttributedString, right: NSMutableAttributedString) -> NSMutableAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

func useSmallerFonts() -> Bool {
    return (UIScreen.main.currentMode!.size.width >= 750) ? false : true
}
