//
//  UIFont-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIFont {
	public func withSize(_ fontSize: CGFloat) -> UIFont {
		return UIFont(name: self.fontName, size: fontSize)!
	}

	public func withSizeScaled(_ scale: CGFloat) -> UIFont {
		return UIFont(name: self.fontName, size: floor(self.pointSize * scale))!
	}

	public static func listAvailableFonts() {
		for family in UIFont.familyNames {
			print("\(family)")

			for names in UIFont.fontNames(forFamilyName: family) {
				print("== \(names)")
			}
		}
	}
}

