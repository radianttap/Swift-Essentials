//
//  UIBarButtonItem-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2019 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//
//	Credits: https://getswifty.dev/adding-closures-to-buttons-in-swift/
//

import UIKit

extension UIBarButtonItem {
	public typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

	private class UIBarButtonItemClosureWrapper: NSObject {
		let closure: UIBarButtonItemTargetClosure
		init(_ closure: @escaping UIBarButtonItemTargetClosure) {
			self.closure = closure
		}
	}

	private struct AssociatedKeys {
		static var targetClosure = "targetClosure"
	}

	private var targetClosure: UIBarButtonItemTargetClosure? {
		get {
			guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIBarButtonItemClosureWrapper else { return nil }
			return closureWrapper.closure
		}
		set(newValue) {
			guard let newValue = newValue else { return }
			objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIBarButtonItemClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	@objc func closureAction() {
		guard let targetClosure = targetClosure else { return }
		targetClosure(self)
	}

	convenience init(title: String?, style: UIBarButtonItem.Style, closure: @escaping UIBarButtonItemTargetClosure) {
		self.init(title: title, style: style, target: nil, action: nil)
		targetClosure = closure
		action = #selector(UIBarButtonItem.closureAction)
	}

	convenience init(image: UIImage?, style: UIBarButtonItem.Style, closure: @escaping UIBarButtonItemTargetClosure) {
		self.init(image: image, style: style, target: nil, action: nil)
		targetClosure = closure
		action = #selector(UIBarButtonItem.closureAction)
	}

	convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, closure: @escaping UIBarButtonItemTargetClosure) {
		self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
		targetClosure = closure
		action = #selector(UIBarButtonItem.closureAction)
	}

}
