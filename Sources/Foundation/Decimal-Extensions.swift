import Foundation

public extension Decimal {
	var floored: Decimal {
		return Decimal(
			floor((self as NSDecimalNumber).doubleValue)
		)
	}

	var ceiled: Decimal {
		return Decimal(
			ceil((self as NSDecimalNumber).doubleValue)
		)
	}
	
	var doubleValue:Double {
		return NSDecimalNumber(decimal:self).doubleValue
	}
}
