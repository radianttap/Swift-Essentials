//
//  UILayoutPriority-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UILayoutPriority {

	/*
	Credits: Keith Harrison
	https://useyourloaf.com/blog/easier-swift-layout-priorities/
	*/
	public static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue + rhs)
	}

	public static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue - rhs)
	}
}
