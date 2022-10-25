//
//  UITableView-Extensions.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public extension UITableView {
	var sectionsIndexSet: IndexSet {
		return IndexSet(integersIn: 0..<self.numberOfSections)
	}
	var visibleTopIndexPath: IndexPath? {
        let visibleRows = indexPathsForVisibleRows ?? []
        let firstPath: IndexPath
        let secondPath: IndexPath

        if visibleRows.isEmpty {
            return nil
        } else if visibleRows.count == 1 {
            return visibleRows.first
        } else {
            firstPath = visibleRows[0]
            secondPath = visibleRows[1]
        }

        let firstRowRect = rectForRow(at: firstPath)
        return firstRowRect.origin.y > contentOffset.y ? firstPath : secondPath
    }

}


public extension UITableView {
    func reloadWithoutAnimation(){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
}


public extension UITableView {
    func scrollToLastRow() {
        let indexPath = IndexPath(row:0,section: 0)
        self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func scrollToSelectedRow() {
        let selectedRows = self.indexPathsForVisibleRows
        if let selectedRow = selectedRows?[0] as NSIndexPath? {
            self.scrollToRow(at: selectedRow as IndexPath, at: .middle, animated: true)
        }
    }
    func scrollToHeader() {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    func removeEliminateExtraSeparators() {
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame:.zero)
    }
    func registerCell(_ cellTypes:[AnyClass]) {
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: ".nib")
            if xibPath == nil {
                register(cellType, forCellReuseIdentifier: typeString)
            } else {
                register(UINib(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
            }
        }
    }
}
