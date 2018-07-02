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

