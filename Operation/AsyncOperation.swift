//
//  AsyncOperation.swift
//  Radiant Tap Essentials
//
//  Copyright © 2017 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation

class AsyncOperation : Operation {
	enum State {
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

	fileprivate(set) var state = State.ready {
		willSet {
			willChangeValue(forKey: state.key)
		}
		didSet {
			didChangeValue(forKey: state.key)
		}
	}

	final override var isAsynchronous: Bool {
		return true
	}

	final override var isExecuting: Bool {
		return state == .executing
	}

	final override var isFinished: Bool {
		return state == .finished
	}

//	override var isReady: Bool {
//		return state == .ready
//	}


	//MARK: Setup

	///	Do not override this method, ever. Call it from `workItem()` instead
	final func markFinished() {
		state = .finished
	}

	/// You **should** override this method and do your async work here.
	///	**Must** call `markFinished()` inside your override when async work is done since operation needs to be mark `finished`.
	func workItem() {
		markFinished()
	}

	required override init() {
		fatalError("Can't use this directly. Subclass and override only workItem() *and* make sure you call markCompleted() where appropriate.")
	}

	//MARK: Control

	final override func start() {
		if isCancelled {
			state = .finished
			return
		}

		state = .ready
		main()
	}

	final override func main() {
		if isCancelled {
			state = .finished
			return
		}

		state = .executing
		workItem()
	}
}
