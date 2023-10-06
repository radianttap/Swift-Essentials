//
//  UIView-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public extension UIView {
	 var top: CGFloat {
		return frame.minY
	}
	 var bottom: CGFloat {
		return frame.maxY
	}
	 var left: CGFloat {
		return frame.minX
	}
	 var right: CGFloat {
		return frame.maxX
	}

	//	Methods

	func animateAlpha(to alpha: CGFloat, duration: TimeInterval = 0.3) {
		UIView.animate(withDuration: duration) {
			[unowned self] in
			self.alpha = alpha
		}
	}

	func animateLayout(duration: TimeInterval = 0.3,
							include: (() -> Void)? = nil,
							completion: ((Bool) -> Void)? = nil) {

		UIView.animate(withDuration: duration, animations: {
				[unowned self] in
				if let include = include { include() }
				self.layoutIfNeeded()
			}, completion: completion)
	}

	func springLayout(duration: TimeInterval = 0.3,
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

	func mask(corners: UIRectCorner = [], cornerRadius: CGFloat = 4) {
		let maskPath = UIBezierPath(roundedRect: bounds,
		                            byRoundingCorners: corners,
		                            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
		let maskLayer = CAShapeLayer()
		maskLayer.frame = bounds
		maskLayer.path = maskPath.cgPath
		layer.mask = maskLayer
	}
}

public extension UIView {
	
	func applyShadow(offset: CGSize = CGSize(width: 0, height: 2)) {
		let layer = self.layer
		
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = offset
		layer.shadowOpacity = 0.2
		layer.shadowRadius = 4
	}
	
	func applyCurvedShadow() {
		let size = self.bounds.size
		let width = size.width
		let height = size.height
		let depth = CGFloat(11.0)
		let lessDepth = 0.8 * depth
		let curvyness = CGFloat(5)
		let radius = CGFloat(1)
		
		let path = UIBezierPath()
		// top left
		path.move(to: CGPoint(x: radius, y: height))
		// top right
		path.addLine(to: CGPoint(x: width - 2*radius, y: height))
		// bottom right + a little extra
		path.addLine(to: CGPoint(x: width - 2*radius, y: height + depth))
		// path to bottom left via curve
		path.addCurve(to: CGPoint(x: radius, y: height + depth),
					  controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
					  controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
		
		let layer = self.layer
		layer.shadowPath = path.cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowRadius = radius
		layer.shadowOffset = CGSize(width: 0, height: -3)
	}
	
	func applyHoverShadow() {
		let size = self.bounds.size
		let width = size.width
		let height = size.height
		
		let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
		let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
		
		let layer = self.layer
		layer.shadowPath = path.cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.2
		layer.shadowRadius = 5
		layer.shadowOffset = CGSize(width: 0, height: 0)
	}
}

