//
//  String-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

//	MARK: AttributedString

public extension String {
	func applyFont(_ font: UIFont, for term: String) -> NSAttributedString? {
		guard let _ = self.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return nil }
		
		let string = self as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])
		
		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes(
			[NSAttributedString.Key.font: font],
			range: range
		)
		return attrString
	}
	
	func applyFont(_ font: UIFont, at range: NSRange) -> NSAttributedString? {
		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes(
			[.font: font],
			range: range
		)
		return attrString
	}
	
	func colorize(term: String, usingColor color: UIColor = .red) -> NSAttributedString? {
		guard let _ = self.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return nil }
		
		let string = self as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])
		
		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes(
			[.foregroundColor: color],
			range: range
		)
		return attrString
	}
	
	func strikethrough() -> NSAttributedString? {
		let str = self
		guard str.count > 0 else { return nil }
		
		let range = NSRange(location: 0, length: str.count)
		
		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes(
			[.strikethroughStyle: NSUnderlineStyle.single.rawValue],
			range: range
		)
		return attrString
	}
	
	func underlined(_ str: String? = nil, color: UIColor = .lightGray) -> NSAttributedString? {
		let term = str ?? self
		guard let _ = self.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return nil }
		
		let string = self as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])
		
		let attrString = NSMutableAttributedString(string: self)
		attrString.addAttributes(
			[
				.foregroundColor: color,
				.underlineStyle: NSUnderlineStyle.single.rawValue
			],
			range: range
		)
		return attrString
	}
	
	func original(from label: UILabel) -> NSAttributedString? {
		let str = self
		guard str.count > 0, let font = label.font else { return nil }
		
		let range = NSRange(location: 0, length: str.count)

		let labelColor: UIColor
		if #available(iOS 13.0, *) {
			labelColor = label.textColor ?? .label
		} else {
			labelColor = label.textColor ?? .black
		}
		
		let attrString = NSMutableAttributedString(string: str)
		attrString.addAttributes(
			[
				.foregroundColor: labelColor,
				.font: font
			],
			range: range
		)
		return attrString
	}
}

public extension NSMutableAttributedString {
	
	@discardableResult
	func colorize(term: String, usingColor color: UIColor = .red) -> NSMutableAttributedString {
		guard let _ = self.string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive]) else { return self }
		
		let string = self.string as NSString
		let range = string.range(of: term, options: [.caseInsensitive, .diacriticInsensitive])
		
		addAttributes(
			[.foregroundColor: color],
			range: range
		)
		
		return self
	}
	
	@discardableResult
	func applyFont(_ font: UIFont, at range: NSRange) -> NSMutableAttributedString {
		addAttributes(
			[.font: font],
			range: range
		)
		
		return self
	}
}
