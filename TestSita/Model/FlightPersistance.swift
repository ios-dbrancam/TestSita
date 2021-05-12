import Foundation

struct FlightPersistance {
	
	// File Name & Dir
	private static let persistanceFileName = "persistance"
	private static var path: URL = {
		guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
		return docDir.appendingPathComponent(persistanceFileName).appendingPathExtension("json")
	}()
	
	//MARK: - SAVE
	private static func encode<T: Codable> (_ data: T) -> Data {
		do {
			return try JSONEncoder().encode(data)
		} catch {
			fatalError("Error encoding \(error)")
		}
	}
	
	static func saveToFile<T: Codable> (_ object: T) {
		do {
			try encode(object).write(to: path)
		} catch {
			fatalError("Error writing data \(error)")
		}
	}
	
	//MARK: - LOAD
	private static func decode<T: Codable> (_ data: Data) -> T {
		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			fatalError("Error decoding \(error)")
		}
	}
	
	static func loadPersistanceData<T: Codable> () -> T {
		do {
			return try decode(Data(contentsOf: path))
		} catch {
			fatalError("Error reading data \(error)")
		}
	}
}
