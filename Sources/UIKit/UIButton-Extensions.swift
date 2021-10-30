//
//  UIButton-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2018 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIButton {
	///	Allows automatic response on contentSize change (dynamic type)
    @IBInspectable
    var adjustsFontForContentSizeCategory: Bool {
        set {
            self.titleLabel?.adjustsFontForContentSizeCategory = newValue
        }
        get {
            return self.titleLabel?.adjustsFontForContentSizeCategory ?? false
        }
    }
}
