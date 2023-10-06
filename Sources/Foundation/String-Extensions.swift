import Foundation

public extension String {
	static func random(withLength length: Int) -> String {
		let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let len = UInt32(letters.length)
		
		var randomString = ""
		
		for _ in 0 ..< length {
			let rand = arc4random_uniform(len)
			var nextChar = letters.character(at: Int(rand))
			randomString += NSString(characters: &nextChar, length: 1) as String
		}
		
		return randomString
	}

	///	Uses RegEx pattern from: http://emailregex.com/
	var isValidEmail: Bool {
		let pattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
		"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
		"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
		"z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
		"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
		"9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
		"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

		return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
	}

	/**	Pattern specified by Atlas web API:
	 `^(?=.*[0-9])(?=.*[A-Z])(?=\\S+$).{8,}$`

	 Explanation:

	 - `^` assert position at start of the string
	 - `(?=.*[0-9])` Any number repeated 0 or more times
	 - `(?=.*[A-Z])` Any capital letter repeated 0 or more times
	 - `(?=\S+$)` Any non-whitespace character (`\S+`) repeated 1 or more times
	 - `.{8,}` total character count must be between 8+
	 - `$` assert position at end of the string
	 */
	var isValidPassword: Bool {
		let pattern = "^(?=.*[0-9])(?=.*[A-Z])(?=\\S+$).{8,}$"

		return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
	}

	func usesValidCharacters(from set: CharacterSet = .personalNames) -> Bool {
		let invalidSet = set.inverted
		let cleanSelf = self.components(separatedBy: invalidSet).joined(separator: "")
		return self == cleanSelf
	}

	func usesInvalidCharacters(from set: CharacterSet) -> Bool {
		let cleanSelf = self.components(separatedBy: set).joined(separator: "")
		return self != cleanSelf
	}

	var unescaped: NSString {
		return NSString(string: self)
	}
}

public extension CharacterSet {
	static var personalNames: CharacterSet {
		return .alphanumerics.union(.punctuationCharacters).union(CharacterSet([" "]))
	}
}

//	MARK: Data Detectors

public extension String {
	func detectCheckingTypes(_ types: NSTextCheckingResult.CheckingType = [.link]) -> [NSTextCheckingResult] {
		guard let detector = try? NSDataDetector.init(types: types.rawValue) else {
			return []
		}
		let s = self
		let matches = detector.matches(in: s, options: [], range: NSRange(location: 0, length: s.utf16.count))
		return matches
	}
}

//	MARK: Ranges and Indexes

public extension String {
	//	Credits: Leo Dabus
	//	https://stackoverflow.com/questions/32305891/index-of-a-substring-in-a-string-with-swift

	func index(of string: String, options: CompareOptions = .literal) -> Index? {
		return range(of: string, options: options)?.lowerBound
	}
	func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
		return range(of: string, options: options)?.upperBound
	}
	func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
		var result: [Index] = []
		var start = startIndex
		while let range = range(of: string, options: options, range: start..<endIndex) {
			result.append(range.lowerBound)
			start = range.upperBound
		}
		return result
	}
	func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
		var result: [Range<Index>] = []
		var start = startIndex
		while let range = range(of: string, options: options, range: start..<endIndex) {
			result.append(range)
			start = range.upperBound
		}
		return result
	}
}
