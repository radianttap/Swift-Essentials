//
//  UIKeyboard-Notifications.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

//	@available(iOS 3.2, *)
//	public let UIKeyboardFrameBeginUserInfoKey: String
// NSValue of CGRect

//	@available(iOS 3.2, *)
//	public let UIKeyboardFrameEndUserInfoKey: String
// NSValue of CGRect

//	@available(iOS 3.0, *)
//	public let UIKeyboardAnimationDurationUserInfoKey: String
// NSNumber of double

//	@available(iOS 3.0, *)
//	public let UIKeyboardAnimationCurveUserInfoKey: String
// NSNumber of NSUInteger (UIViewAnimationCurve)

//	@available(iOS 9.0, *)
//	public let UIKeyboardIsLocalUserInfoKey: String
// NSNumber of BOOL

struct KeyboardNotification {
	var beginFrame: CGRect = .zero
	var endFrame: CGRect = .zero
	var animationCurve: UIView.AnimationCurve = .linear
	var animationDuration: TimeInterval = 0.3
	var isLocalForCurrentApp: Bool = false

	init?(notification: Notification) {
		guard let userInfo = notification.userInfo as? [String: Any] else { return nil }

		if let value = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
			beginFrame = value.cgRectValue
		}
		if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			endFrame = value.cgRectValue
		}
		if let value = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int, let curve = UIView.AnimationCurve(rawValue: value) {
			animationCurve = curve
		}
		if let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
			animationDuration = value
		}
		if let value = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool {
			isLocalForCurrentApp = value
		}
	}
}

extension KeyboardNotification {
	static let willShow = NotificationDescriptor<KeyboardNotification>(name: UIResponder.keyboardWillShowNotification, convert: KeyboardNotification.init)
	static let didShow = NotificationDescriptor<KeyboardNotification>(name: UIResponder.keyboardDidShowNotification, convert: KeyboardNotification.init)

	static let willHide = NotificationDescriptor<KeyboardNotification>(name: UIResponder.keyboardWillHideNotification, convert: KeyboardNotification.init)
	static let didHide = NotificationDescriptor<KeyboardNotification>(name: UIResponder.keyboardDidHideNotification, convert: KeyboardNotification.init)
}
