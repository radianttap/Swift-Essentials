//
//  UIKit-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIView {
	func grepSubviews<T: UIView>() -> [T] {
		return subviews.compactMap { $0 as? T }
	}

	func deepGrepSubviews<T: UIView>() -> [T] {
		var arr: [T] = grepSubviews()

		let children: [T] = subviews.reduce([]) { current, v in
			var arr = current
			let x: [T] = v.deepGrepSubviews()
			arr.append(contentsOf: x)
			return arr
		}

		arr.append(contentsOf: children)
		return arr
	}

	func animateAlpha(to value: CGFloat) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			self.alpha = value
		}
	}

	func animateLayout(including block: @escaping () -> Void = {}) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			block()
			self.layoutIfNeeded()
		}
	}

	func springLayout(including block: @escaping () -> Void = {}) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			block()
			self.layoutIfNeeded()
		}
	}
}
