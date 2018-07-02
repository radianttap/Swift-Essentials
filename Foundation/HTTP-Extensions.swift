import Foundation

extension URLResponse {
    
    public func getStatusCode() -> Int? {

        guard let response = self as? HTTPURLResponse else { return nil }

        return response.statusCode
    }
}
