//
//  UIEdgeInsets-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2018 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIEdgeInsets {
	///	Subtracts components in the two arguments and returns the resulting `UIEdgeInsets`. Makes sure that result is never below 0.
	public static func -(lhs: UIEdgeInsets, rhs:UIEdgeInsets) -> UIEdgeInsets {
		var insets = UIEdgeInsets.zero
		insets.top = max(0, lhs.top - rhs.top)
		insets.right = max(0, lhs.right - rhs.right)
		insets.bottom = max(0, lhs.bottom - rhs.bottom)
		insets.left = max(0, lhs.left - rhs.left)
		return insets
	}

	///	Adds each component in the two arguments and returns the resulting `UIEdgeInsets`.
	public static func +(lhs: UIEdgeInsets, rhs:UIEdgeInsets) -> UIEdgeInsets {
		var insets = UIEdgeInsets.zero
		insets.top = lhs.top + rhs.top
		insets.right = lhs.right + rhs.right
		insets.bottom = lhs.bottom + rhs.bottom
		insets.left = lhs.left + rhs.left
		return insets
	}
	
	///	Compares each component and uses the larger value in the resulting `UIEdgeInsets`.
	public func union(_ rhs: UIEdgeInsets) -> UIEdgeInsets {
		var insets = UIEdgeInsets.zero
		insets.top = max(top, insets.top)
		insets.right = max(right, insets.right)
		insets.bottom = max(bottom, insets.bottom)
		insets.left = max(left, insets.left)
		return insets
	}
}
