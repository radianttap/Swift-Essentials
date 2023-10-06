//
//  UIGestureRecognizer-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2021 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UIGestureRecognizer {
	
	/// Typealias for UIControl closure.
	typealias UITargetClosure = (UIGestureRecognizer) -> ()
	
	private class UIClosureWrapper: NSObject {
		let closure: UITargetClosure
		init(_ closure: @escaping UITargetClosure) {
			self.closure = closure
		}
	}
	
	private struct AssociatedKeys {
		static var targetClosure: Void?
	}
	
	private var targetClosure: UITargetClosure? {
		get {
			guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIClosureWrapper else { return nil }
			return closureWrapper.closure
		}
		set(newValue) {
			guard let newValue = newValue else { return }
			objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	@objc func closureAction() {
		guard let targetClosure = targetClosure else { return }
		targetClosure(self)
	}
	
	func addAction(closure: @escaping UITargetClosure) {
		targetClosure = closure
		addTarget(self, action: #selector(UIGestureRecognizer.closureAction))
	}
	
	convenience init(closure: @escaping UITargetClosure) {
		self.init()
		addAction(closure: closure)
	}
}
