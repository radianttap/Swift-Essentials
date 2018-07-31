import Foundation

final class NumberKeeper {
	var number: Int

	init(number: Int) {
		self.number = number
	}
}


final class IncrementOperation: AsyncOperation {
	var numberKeeper: NumberKeeper

	required init() {
		fatalError("init() has not been implemented")
	}

	init(_ numberKeeper: NumberKeeper) {
		self.numberKeeper = numberKeeper
	}

	override func workItem() {
		let delay = TimeInterval( Int(arc4random()) % 100_000 ) / 30_000

		DispatchQueue.init(label: "Incremented").asyncAfter(deadline: .now() + delay) {
			[weak self] in

			self?.numberKeeper.number += 1
			print(self?.numberKeeper.number ?? -1)

			self?.markFinished()
		}
	}
}

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 1

let numberKeeper = NumberKeeper(number: 0)

for _ in 0..<10 {
	let op = IncrementOperation(numberKeeper)
	queue.addOperation(op)
}
