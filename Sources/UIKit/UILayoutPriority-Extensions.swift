//
//  UILayoutPriority-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public extension UILayoutPriority {

	/*
	Credits: Keith Harrison
	https://useyourloaf.com/blog/easier-swift-layout-priorities/
	*/
	 static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue + rhs)
	}

	 static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue - rhs)
	}
}
