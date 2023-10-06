//
//  UILabel-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2023 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UILabel {
	func handleInteractionWithCheckingType(_ match: NSTextCheckingResult, inside view: UIView) {
		guard 
			let string = self.text, string.count > 0,
			let attrString = self.attributedText
		else {
			return
		}
		
		let matchRange = match.range
		guard let range = Range(matchRange, in: string) else { return }
		let term = String(string[range])

		isUserInteractionEnabled = true

		switch match.resultType {
			case .link:
				//	handle tap on links
				let tapGR = UITapGestureRecognizer {
					[weak self] gr in
					guard let self, let url = URL(string: term) else { return }
					
					if self.hasInteractedWith(gr, over: attrString, atRange: matchRange) {
						//	do something, like open this URL
						UIApplication.shared.open(url)
					}
				}
				addGestureRecognizer(tapGR)
				
			default:
				break
		}
	}

	func hasInteractedWith(_ gr: UIGestureRecognizer, over attrString: NSAttributedString, atRange matchRange: NSRange) -> Bool {
		let layoutManager = NSLayoutManager()
		let textContainer = NSTextContainer(size: .zero)
		let textStorage = NSTextStorage.init(attributedString: attrString)
		
		layoutManager.addTextContainer(textContainer)
		textStorage.addLayoutManager(layoutManager)
		
		// configure textContainer for the label
		textContainer.lineFragmentPadding = 0.0
		textContainer.lineBreakMode = self.lineBreakMode
		textContainer.maximumNumberOfLines = self.numberOfLines
		let labelSize = self.bounds.size
		textContainer.size = labelSize
		
		// find the tapped character location and compare it to the specified range
		let loc = gr.location(in: self)
		let textBoundingBox  = layoutManager.usedRect(for: textContainer)
		let textContainerOffset = CGPointMake(
			(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
			(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
		)
		let locationOfTouchInTextContainer = CGPointMake(
			loc.x - textContainerOffset.x,
			loc.y - textContainerOffset.y
		)
		let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
		return matchRange.contains(indexOfCharacter)
	}
}
