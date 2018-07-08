//
//  NetworkOperation.swift
//  Demo
//
//  Created by Aleksandar Vacić on 7/8/18.
//  Copyright © 2018 Radiant Tap. All rights reserved.
//

import Foundation

///	Proper use of Operation to wrap network calls
final class NetworkOperation: AsyncOperation {
	typealias Callback = (Data?, URLResponse?, Error?) -> Void

	let url: URL
	let callback: Callback

	required init() {
		fatalError("Use the `init(url:callback:)`")
	}

	init(url: URL, callback: @escaping Callback) {
		self.url = url
		self.callback = callback
		super.init()
	}

	//	The main part

	private(set) var task: URLSessionDataTask?

	override func workItem() {
		task = URLSession.shared.dataTask(with: url) {
			[weak self] data, response, error in

			self?.callback(data, response, error)

			self?.markFinished()
		}
		task?.resume()
	}
}

