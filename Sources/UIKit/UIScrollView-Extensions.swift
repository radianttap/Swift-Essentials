//
//  UIScrollView-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIScrollView {
	///	Scroll so `rect` is just visible (nearest edges). Does nothing if rect completely visible.
	///	If `rect` is larger than available bounds, then it scrolls so the top edge stays visible.
	open func scrollTopRectToVisible(_ rect: CGRect, animated: Bool) {
		let visibleRect = self.bounds
		let diff = rect.height - visibleRect.height
		if diff < 0 {
			scrollRectToVisible(rect, animated: true)
			return
		}

		let diffY = rect.minY - visibleRect.minY
		var offset = contentOffset
		offset.y += diffY
		setContentOffset(offset, animated: animated)
	}
}
