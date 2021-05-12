import UIKit

enum ImageError: Error {
	case missingURL
	case creationError
}

class FlightStore
{
	private let session: URLSession = {
		let configuration = URLSessionConfiguration.default
		return URLSession(configuration: configuration)
	}()
	
	//MARK: - Data Request
	private func processFlightRequest(data: Data?, error: Error?) -> Result<[Flight], Error> {
		guard let data = data else {
			return .failure(error!)
		}
		return FlightAPI.decode(fromJSON: data)
	}
	
	func fetchFlights(completion: @escaping (Result<[Flight], Error>) -> Void) {
		let request = URLRequest(url: FlightAPI.apiURL)
		let _ = session.dataTask(with: request) { (data, _, error) in
			let result = self.processFlightRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
		}.resume()
	}
	
	//MARK: - Image Request
	private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
		guard let data = data, let image = UIImage(data: data) else {
			return .failure(ImageError.creationError)
		}
		return .success(image)
	}
	
	func fetchImage(for flight: Flight, completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let image = flight.image, let imageURL = URL(string: image) else {
			completion(.failure(ImageError.missingURL))
			return
		}
		let _ = session.dataTask(with: URLRequest(url: imageURL)) { (data, _, error) in
			let result = self.processImageRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
		}.resume()
	}
}
