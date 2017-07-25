//
//  ReusableView.swift
//  Radiant Tap Essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

///	Protocol to allow any UIView to become reusable view
protocol ReusableView {
	///	By default, it returns the subclass name
	static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}


