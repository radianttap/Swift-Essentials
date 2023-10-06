import UIKit

@available(iOS 13.0, *)
extension UICollectionViewDiffableDataSource {
	func compat_sectionIdentifier(for index: Int) -> SectionIdentifierType? {

		if #available(iOS 15.0, *) {
			return sectionIdentifier(for: index)

		} else {
			let identifiers = snapshot().sectionIdentifiers
			if (0..<identifiers.count).contains(index) {
				return identifiers[index]
			}
			return nil
		}
	}
}
