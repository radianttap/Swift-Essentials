//
//  Swift-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation

extension Dictionary {
	func combinedWith(_ other: [Key: Value]) -> [Key: Value] {
		var dict = self
		for (key, value) in other {
			dict[key] =  value
		}
		return dict
	}
}

