//
//  UIAlertController-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIAlertController {
	static func present(title: String?, message: String?, tintColor: UIColor? = nil, from controller: UIViewController? = nil) {
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

		let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
		ac.addAction(ok)

		if let tintColor = tintColor {
			ac.view.tintColor = tintColor
		}

		let c = controller ?? UIApplication.shared.keyWindow?.rootViewController
		c?.present(ac, animated: true, completion: nil)
	}
}
