//
//  UIView-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIView {
	public var top: CGFloat {
		return frame.minY
	}
	public var bottom: CGFloat {
		return frame.maxY
	}
	public var left: CGFloat {
		return frame.minX
	}
	public var right: CGFloat {
		return frame.maxX
	}

	//	Methods

	open func animateAlpha(to alpha: CGFloat, duration: TimeInterval = 0.3) {
		UIView.animate(withDuration: duration) {
			[unowned self] in
			self.alpha = alpha
		}
	}

	open func animateLayout(duration: TimeInterval = 0.3,
							include: (() -> Void)? = nil,
							completion: ((Bool) -> Void)? = nil) {

		UIView.animate(withDuration: duration, animations: {
				[unowned self] in
				if let include = include { include() }
				self.layoutIfNeeded()
			}, completion: completion)
	}

	open func springLayout(duration: TimeInterval = 0.3,
						   usingSpringWithDamping: CGFloat = 0.96,
						   initialSpringVelocity: CGFloat = 20,
						   options: UIView.AnimationOptions = [.allowAnimatedContent],
						   include: (() -> Void)? = nil,
						   completion: ((Bool) -> Void)? = nil) {

		UIView.animate(withDuration: duration,
		               delay: 0,
		               usingSpringWithDamping: usingSpringWithDamping,
		               initialSpringVelocity: initialSpringVelocity,
		               options: options,
		               animations: {
							[unowned self] in
							if let include = include { include() }
							self.layoutIfNeeded()
			}, completion: completion)
	}

	open func mask(corners: UIRectCorner = [], cornerRadius: CGFloat = 4) {
		let maskPath = UIBezierPath(roundedRect: bounds,
		                            byRoundingCorners: corners,
		                            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
		let maskLayer = CAShapeLayer()
		maskLayer.frame = bounds
		maskLayer.path = maskPath.cgPath
		layer.mask = maskLayer
	}
}
