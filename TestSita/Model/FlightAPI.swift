import Foundation

struct FlightAPI {
	
	static private let urlStr = "https://2a6d3177-4681-4fc9-97b9-e4e9580db87a.mock.pstmn.io/airlines"
	static let apiURL = URL(string: FlightAPI.urlStr)!
	
	static func decode<T: Codable> (fromJSON data: Data) -> Result<[T], Error> {
		do {
			let response = try JSONDecoder().decode([T].self, from: data)
			return .success(response)
		} catch {
			return .failure(error)
		}
	}
}
