//
//  DequeableView.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit


extension UICollectionView {

	//	register for the Class-based cell
	public func register<T: UICollectionViewCell>(_: T.Type, withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier)
		where T: ReusableView
	{
		register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
	}

	//	register for the Nib-based cell
	public func register<T: UICollectionViewCell>(_: T.Type, withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier)
		where T:NibReusableView
	{
		register(T.nib, forCellWithReuseIdentifier: reuseIdentifier)
	}

	public func dequeueReusableCell<T: UICollectionViewCell>(withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier, forIndexPath indexPath: IndexPath) -> T
		where T:ReusableView
	{
		//	this deque and cast can fail if you forget to register the proper cell
		guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
			//	thus crash instantly and nudge the developer
			fatalError("Dequeing a cell with identifier: \( reuseIdentifier ) failed.\nDid you maybe forget to register it in viewDidLoad?")
		}
		return cell
	}

	//	register for the Class-based supplementary view
	public func register<T: UICollectionReusableView>(_: T.Type, kind: String)
		where T:ReusableView
	{
		register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
	}

	//	register for the Nib-based supplementary view
	public func register<T: UICollectionReusableView>(_: T.Type, kind: String)
		where T:NibReusableView
	{
		register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
	}

	public func dequeueReusableView<T: UICollectionReusableView>(kind: String, atIndexPath indexPath: IndexPath) -> T
		where T:ReusableView
	{
		//	this deque and cast can fail if you forget to register the proper cell
		guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			//	thus crash instantly and nudge the developer
			fatalError("Dequeing supplementary view of kind: \( kind ) with identifier: \( T.reuseIdentifier ) failed.\nDid you maybe forget to register it in viewDidLoad?")
		}
		return view
	}
}


extension UITableView {

	//	register for the Class-based cell
	public func register<T: UITableViewCell>(_: T.Type, withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier)
		where T: ReusableView
	{
		register(T.self, forCellReuseIdentifier: reuseIdentifier)
	}

	//	register for the Nib-based cell
	public func register<T: UITableViewCell>(_: T.Type, withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier)
		where T:NibReusableView
	{
		register(T.nib, forCellReuseIdentifier: reuseIdentifier)
	}

	public func dequeueReusableCell<T: UITableViewCell>(withReuseIdentifier reuseIdentifier: String = T.reuseIdentifier, forIndexPath indexPath: IndexPath) -> T
		where T:ReusableView
	{
		guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
			fatalError("Dequeing a cell with identifier: \(reuseIdentifier) failed.\nDid you maybe forget to register it in viewDidLoad?")
		}
		return cell
	}

	//	register for the Class-based header/footer view
	public func register<T: UITableViewHeaderFooterView>(_: T.Type)
		where T:ReusableView
	{
		register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
	}

	//	register for the Nib-based header/footer view
	public func register<T: UITableViewHeaderFooterView>(_: T.Type)
		where T:NibReusableView
	{
		register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
	}

	public func dequeueReusableView<T: UITableViewHeaderFooterView>() -> T?
		where T:ReusableView
	{
		let v = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
		return v
	}
}

