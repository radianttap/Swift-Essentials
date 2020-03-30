//
//  RequestOperation.swift
//  AsyncOperationDemo
//
//  Created by aodhol
//	https://github.com/aodhol/RaceCondition/blob/master/RaceCondition.playground/Contents.swift
//

import Foundation

class RequestOperation: AsyncOperation {
	
	private var URLSessionTaksOperationKVOContext = 0
	
	let request: URLRequest
	var task: URLSessionTask?
	
	var data: Data?
	
	init(request: URLRequest) {
		self.request = request
	}
	
	required public init() {
		fatalError("init() has not been implemented")
	}
	
	override func workItem() {
		print("Request: starting")
		
		task = URLSession.shared.dataTask(with: request) {
			[weak self] (data, response, error) in
			guard let data = data,
				let httpUrlResponse = response as? HTTPURLResponse,
				let mimeType = httpUrlResponse.mimeType,
				mimeType == "application/json",
				httpUrlResponse.statusCode == 200,
				error == nil
			else {
				print("Request executing, error: \(error?.localizedDescription ?? "")")
				return
			}

			print("Request: executing, data fetched")
			self?.data = data
			
			self?.markFinished()
		}
		task?.resume()
	}
}

