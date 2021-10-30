//
//  UICollectionView-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UICollectionView {
	var sectionsIndexSet: IndexSet {
		return IndexSet(integersIn: 0..<self.numberOfSections)
	}
}


extension UICollectionView {
	func reloadDataWithoutAnimation() {
		CATransaction.begin()
		CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)

		self.reloadData()

		CATransaction.commit()
	}

	func reloadSectionsWithoutAnimation(_ sections: IndexSet) {
		CATransaction.begin()
		CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
		
		self.reloadSections(sections)
		
		CATransaction.commit()
	}

	func reloadIndexPathsWithoutAnimation(_ indexPaths: [IndexPath]) {
		CATransaction.begin()
		CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
		
		self.reloadItems(at: indexPaths)
		
		CATransaction.commit()
	}
}
