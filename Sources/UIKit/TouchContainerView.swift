//
//  TouchContainerView.swift
//  Radiant Tap Essentials
//
//  Copyright © 2015 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

///	UIView subclass which "catches" touches on any of its subviews,
///	even if those subviews are outside this view's frame.
///
///	Note: you must set `clipsToBounds=false` on this view.
class TouchContainerView: UIView {

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if !isUserInteractionEnabled {
			return nil
		}
		for view in subviews.reversed() {
			let subPoint = view.convert(point, from: self)
			if let v = view.hitTest(subPoint, with: event) {
				return v
			}
		}

		return nil
	}
}
