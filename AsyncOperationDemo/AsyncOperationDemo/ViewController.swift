//
//  ViewController.swift
//  AsyncOperationDemo
//
//  Created by Aleksandar Vacić on 9/3/18.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		fetchStuff { (user) in
			print("User: \(user?.first_name ?? "empty")")
		}
	}


	//	from aodhol
	//	https://github.com/aodhol/RaceCondition/blob/master/RaceCondition.playground/Contents.swift

	let queue = OperationQueue()

	// Nested because the actual user is under a 'data' key in the JSON :(
	struct UserData: Decodable {
		struct User: Decodable {
			let first_name: String
		}
		let data: User
	}

	func fetchStuff(completion: (_ response: UserData.User?) -> Void) {

		let request = RequestOperation(request: URLRequest(url: URL(string: "https://reqres.in/api/users/2")!))
		let decode = DecodeOperation<UserData>()

		let adapter = AdapterOperation() {
			[unowned decode, unowned request] in
			
			print("Adapter: executing, set bytes to decode: \(request.data?.count ?? 0)")
			decode.data = request.data
		}

		adapter.addDependency(request)
		decode.addDependency(adapter)

//		queue.maxConcurrentOperationCount = 1
		queue.addOperations([request, adapter, decode], waitUntilFinished: true)

		completion(decode.decoded?.data)
	}

}
