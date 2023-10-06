import UIKit

extension UIStackView {
	func removeAllSubviews() {
		for v in arrangedSubviews {
			removeArrangedSubview(v)
			v.removeFromSuperview()
		}
	}
}
