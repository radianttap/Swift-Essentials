//
//  CALayer-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2020 Aleksandar Vacić, Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public extension CALayer {
	func addShadow(
		opacity: Float = 0.2,
		radius: CGFloat = 10,
		offset: CGSize = CGSize(width: 0, height: 8),
		color: UIColor = .black
	) {
		self.shadowOffset = offset
		self.shadowOpacity = opacity
		self.shadowRadius = radius
		self.shadowColor = color.cgColor
		self.masksToBounds = false

		if cornerRadius != 0 {
			addShadowWithRoundedCorners()
		}
	}

	func roundCorners(radius: CGFloat) {
		self.cornerRadius = radius

		if shadowOpacity != 0 {
			addShadowWithRoundedCorners()
		}
	}

	private func addShadowWithRoundedCorners() {
		if let contents = self.contents {
			masksToBounds = false

			sublayers?
				.filter{ $0.frame.equalTo(self.bounds) }
				.forEach{ $0.roundCorners(radius: self.cornerRadius) }

			self.contents = nil

			if
				let sublayer = sublayers?.first,
				sublayer.name == "roundedShadowLayer"
			{
				sublayer.removeFromSuperlayer()
			}

			let contentLayer = CALayer()
			contentLayer.name = "roundedShadowLayer"
			contentLayer.contents = contents
			contentLayer.frame = bounds
			contentLayer.cornerRadius = cornerRadius
			contentLayer.masksToBounds = true
			insertSublayer(contentLayer, at: 0)
		}
	}
}
