//
//  ProperNetworkOperation.swift
//  Demo
//
//  Created by Aleksandar Vacić on 7/8/18.
//  Copyright © 2018 Radiant Tap. All rights reserved.
//

import Foundation

///	An proof-of-concept how Operation should be used to wrap network calls
final class ProperNetworkOperation: Operation {
	typealias Callback = (Data?, URLResponse?, Error?) -> Void

	let url: URL
	let callback: Callback

	init(url: URL, callback: @escaping Callback) {
		self.url = url
		self.callback = callback
		super.init()
	}

	override func main() {
		let task = URLSession.shared.dataTask(with: url) {
			[weak self] data, response, error in

			self?.callback(data, response, error)

			//	mark as Finished NOW!
			//	(see NetworkOperation.swift how that's done)
		}
		task.resume()
	}
}

