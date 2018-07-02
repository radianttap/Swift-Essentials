//
//  UIColor-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//
//	Credits:
//	https://cocoacasts.com/from-hex-to-uicolor-and-back-in-swift/
//	https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
//
#if os(iOS)
	import UIKit
#endif

#if os(watchOS)
	import WatchKit
#endif

extension UIColor {
	convenience init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: UInt32 = 0
		if !Scanner(string: hexSanitized).scanHexInt32(&rgb) { return nil }

		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 1.0

		let length = hexSanitized.count
		if length == 6 {	//RGB
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0

		} else if length == 8 {	//	RGBa
			r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			a = CGFloat(rgb & 0x000000FF) / 255.0

		} else {
			return nil
		}

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	func toHex(alpha: Bool = false) -> String? {
		guard let components = cgColor.components, components.count >= 3 else {
			return nil
		}
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		var a = Float(1.0)

		if components.count >= 4 {
			a = Float(components[3])
		}

		/*
		The string format specifier may need an explanation.
		You can break it down into several components.
			* % defines the format specifier
			* 02 defines the length of the string
			* l casts the value to an unsigned long
			* X prints the value in hexadecimal (0–9 and A-F)
		*/
		if alpha {
			return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
		} else {
			return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
		}
	}

	var toHex: String? {
		return toHex()
	}
}
