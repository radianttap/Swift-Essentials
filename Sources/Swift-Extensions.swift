//
//  Swift-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation

public extension Dictionary {
	func combinedWith(_ other: [Key: Value]) -> [Key: Value] {
		var dict = self
		for (key, value) in other {
			dict[key] =  value
		}
		return dict
	}

	mutating func mergedWith(_ other: [Key: Value]) {
		for (key, value) in other {
			self[key] = value
		}
	}

	func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T : Value] where T: Hashable {
		var dict: [T: Value] = [:]
		for (key, value) in self {
			let newKey = try transform(key)
			dict[newKey] = value
		}
		return dict
	}

	func remap(keys mapping: [Key: Key]) -> [Key: Value] {
		var dict: [Key: Value] = [:]
		for (key, value) in self {
			var newKey = key
			if let k = mapping[key] {
				newKey = k
			}
			if let d = value as? [Key: Value] {
				dict[newKey] = d.remap(keys: mapping) as? Value

			} else if let a = value as? Array<[Key: Value]> {
				dict[newKey] = a.map({ $0.remap(keys: mapping) }) as? Value

			} else {
				dict[newKey] = value
			}
		}
		return dict
	}

	func deepRecompose(keys mapping: [[Key]: Key]) -> [Key: Value] {
		var dict: [Key: Value] = [:]
		for (key, value) in self {
			if let d = value as? [Key: Value] {
				dict[key] = d.recompose(using: mapping) as? Value

			} else if let a = value as? Array<[Key: Value]> {
				dict[key] = a.map({ $0.recompose(using: mapping) }) as? Value

			} else {
				dict[key] = value
			}
		}
		return dict
	}

	func recompose(using mapping: [[Key]: Key]) -> [Key: Value] {
		var nd = self
		for (arrKeys, newKey) in mapping {
			let arrValues = arrKeys.compactMap { self[$0] }
			//	make sure all keys are found
			if arrKeys.count == arrValues.count {
				//	pickup those key-value pairs and combined them into new Dictionary value
				let newValue: [Key: Value] = arrKeys.enumerated().reduce([:]) {
					var builder = $0
					builder[$1.element] = arrValues[$1.offset]
					return builder
				}
				//	then add it value for target key
				nd[newKey] = newValue as? Value
				//	now clean pairs
				arrKeys.forEach { nd.removeValue(forKey: $0) }
			}
		}
		return nd
	}
}

public extension Dictionary where Value: Equatable {
	func key(from value: Value) -> Key? {
		return self.first(where: { $0.value == value })?.key
	}
}

public extension Set {
	mutating func toggle(_ element: Element) {
		if self.contains(element) {
			self.remove(element)
		} else {
			self.insert(element)
		}
	}
}

public extension Array {
	var randomElement: Element? {
		let n = Int(arc4random_uniform(UInt32(self.count)))
		let index = self.index(self.startIndex, offsetBy: n)
		return self.count > 0 ? self[index] : nil
	}

	func anyInstance<T>() -> T? {
		first(where: { $0 is T }) as? T
	}
}

public extension Sequence where Iterator.Element: Hashable {
	func unique() -> [Iterator.Element] {
		var seen: Set<Iterator.Element> = []
		return filter { seen.insert($0).inserted }
	}
}
