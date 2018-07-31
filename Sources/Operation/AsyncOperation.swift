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
	public enum State {
		case ready
		case executing
		case finished

		fileprivate var key: String {
			switch self {
			case .ready:
				return "isReady"
			case .executing:
				return "isExecuting"
			case .finished:
				return "isFinished"
			}
		}
	}

	private let queue = DispatchQueue(label: "com.radianttap.Essentials.AsyncOperation")

	public private(set) var state: State {
		get { return queue.sync { return _state } }
		set { queue.sync { _state = newValue } }
	}

	private var _state = State.ready {
		willSet {
			willChangeValue(forKey: _state.key)
			willChangeValue(forKey: newValue.key)
		}
		didSet {
			didChangeValue(forKey: oldValue.key)
			didChangeValue(forKey: _state.key)
		}
	}

	final override public var isAsynchronous: Bool {
		return true
	}

	final override public var isExecuting: Bool {
		return state == .executing
	}

	final override public var isFinished: Bool {
		return state == .finished
	}

	final override public var isReady: Bool {
		return state == .ready
	}


	//MARK: Setup

	///	Do not override this method, ever. Call it from `workItem()` instead
	final public func markFinished() {
		state = .finished
	}

	/// You **should** override this method and start and/or do your async work here.
	///	**Must** call `markFinished()` inside your override
	///	when async work is done since operation needs to be mark `finished`.
	open func workItem() {
		markFinished()
	}

	required override public init() {
	}

	//MARK: Control

	final override public func start() {
		if isCancelled {
			state = .finished
			return
		}

		main()
	}

	final override public func main() {
		if isCancelled {
			state = .finished
			return
		}

		state = .executing
		workItem()
	}
}
