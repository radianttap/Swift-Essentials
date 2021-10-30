//
//  UIControl-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2019 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//
//	Credits: https://getswifty.dev/adding-closures-to-buttons-in-swift/
//

import UIKit

extension UIControl {

	/// Typealias for UIControl closure.
	public typealias UIControlTargetClosure = (UIControl) -> ()

	private class UIControlClosureWrapper: NSObject {
		let closure: UIControlTargetClosure
		init(_ closure: @escaping UIControlTargetClosure) {
			self.closure = closure
		}
	}

	private struct AssociatedKeys {
		static var targetClosure = "targetClosure"
	}

	private var targetClosure: UIControlTargetClosure? {
		get {
			guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
			return closureWrapper.closure
		}
		set(newValue) {
			guard let newValue = newValue else { return }
			objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	@objc func closureAction() {
		guard let targetClosure = targetClosure else { return }
		targetClosure(self)
	}

	public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
		targetClosure = closure
		addTarget(self, action: #selector(UIControl.closureAction), for: event)
	}

}
