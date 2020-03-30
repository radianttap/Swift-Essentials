//
//  AsyncOperation.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation

open class AsyncOperation : Operation {
	private var hasAsyncFinished = false

	final override public var isAsynchronous: Bool {
		return true
	}
	
	final override public var isFinished: Bool {
		return hasAsyncFinished
	}
	
	final override public var isExecuting: Bool {
		return !hasAsyncFinished
	}

	//MARK: Setup

	///	Call this method from `workItem()`.
	final public func markFinished() {
		willChangeValue(forKey: "isExecuting")
		willChangeValue(forKey: "isFinished")
		hasAsyncFinished = true
		didChangeValue(forKey: "isExecuting")
		didChangeValue(forKey: "isFinished")
	}

	/// Override this method and perform your async work here.
	///
	///	**Must** call `markFinished()` inside your override when async work is done in order to mark the operation as `finished`.
	open func workItem() {
		markFinished()
	}

	required override public init() {}

	//MARK: Control
	
	open override func cancel() {
		hasAsyncFinished = true
		super.cancel()
	}
	
	final override public func main() {
		if hasAsyncFinished {
			return
		}

		workItem()
	}
}
