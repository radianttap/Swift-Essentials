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
		print("Decode: starting")
		do {
			guard let data = data else {
				print("Decode: executting, error: data not set")
				markFinished()
				return
			}
			
			print("Decode: executing, decoding: \(data)")
			self.decoded = try JSONDecoder().decode(T.self, from: data)
		} catch let error {
			print("Decode, error: \(error.localizedDescription)")
		}
		
		self.markFinished()
	}
}

