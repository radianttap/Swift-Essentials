//
//  String-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public extension String {

	 func colorize(term: String, color: UIColor) -> NSAttributedString? {
		guard let _ = self.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return nil }

		let string = self as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])

		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes([NSAttributedString.Key.foregroundColor: color],
								 range: range)
		return attrString
	}

	 func strikethrough(_ str: String? = nil, color: UIColor? = nil) -> NSAttributedString? {
		let term = str ?? self
		guard let _ = self.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return nil }

		let string = self as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])

		let attrString = NSMutableAttributedString(string: self)
		var attr: [NSAttributedString.Key: Any] = [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
		if let color = color {
			attr[.foregroundColor] = color
		}
		attrString.addAttributes(attr, range: range)
		return attrString
	}
}

