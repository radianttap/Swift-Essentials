//
//  DynamicFont.swift
//
//  Credits:
//  Paulo Andrade, https://pfandrade.me/blog/dynamicfont/
//

import UIKit

@propertyWrapper
public struct DynamicFont {
    public var textStyle: UIFont.TextStyle
    public var maximumPointSize: CGFloat?
    
    public var baseFont: UIFont
    public var wrappedValue: UIFont {
        get {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            if let mps = maximumPointSize {
                return metrics.scaledFont(for: baseFont, maximumPointSize: mps)
            } else {
                return metrics.scaledFont(for: baseFont)
            }
        }
        set { baseFont = newValue }
    }
    
	public init(wrappedValue font: UIFont, withMetricsForTextStyle textStyle: UIFont.TextStyle = .body, maximumPointSize: CGFloat? = nil) {
        self.textStyle = textStyle
        self.baseFont = font
        self.maximumPointSize = maximumPointSize
    }
}
