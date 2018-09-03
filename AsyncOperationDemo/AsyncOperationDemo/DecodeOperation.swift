//
//  DecodeOperation.swift
//  AsyncOperationDemo
//
//  Created by aodhol
//	https://github.com/aodhol/RaceCondition/blob/master/RaceCondition.playground/Contents.swift
//

import Foundation

class DecodeOperation<T: Decodable>: AsyncOperation {

	var data: Data? = nil
	var decoded: T? = nil

	override func workItem() {
		print("starting decode op")
		do {
			guard let data = data else {
				print("data not set")
				markFinished()
				return
			}
			print("decoding: \(data)")
			self.decoded = try JSONDecoder().decode(T.self, from: data)
		} catch let error {
			print("ERROR: \(error.localizedDescription)")
		}
		self.markFinished()
	}
}

