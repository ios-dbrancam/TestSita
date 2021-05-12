import UIKit

class FlightDataSource: NSObject, UICollectionViewDataSource
{
	//MARK: - Data
	private var flights: [Flight] = []
	func updateFlights(_ fetchedFlights: [Flight]) {
		flights = fetchedFlights
	}
	
	
	//MARK: - Search
	private var strFilter: String?
	
	func setFilter(_ filter: String) {
		strFilter = filter
	}
	func removeFilter() {
		strFilter = nil
	}
	
	var flightsToDisplay: [Flight] {
		guard let strFilter = strFilter else { return flights }
		return flights.filter { $0.name.lowercased().contains(strFilter.lowercased()) }
	}
	
	
	//MARK: - Favorite
	func setFavorite(_ flight: Flight) {
		guard let flightIndex = flights.firstIndex(where: { $0.id == flight.id }) else { fatalError("Unknown flight")}
		flights[flightIndex].isFavorite = true
	}
	
	
	//MARK: - Data Source
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return flightsToDisplay.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let flight = flightsToDisplay[indexPath.row]
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flightCell", for: indexPath) as! FlightCell
		
		cell.title.text = flight.name
		
		if let isFav = flight.isFavorite, isFav == true {
			let configuration = UIImage.SymbolConfiguration(pointSize: 24)
			cell.isFavorite.image = UIImage(systemName: "star.fill", withConfiguration: configuration)!.withTintColor(UIColor.yellow, renderingMode: .alwaysOriginal)
		}
		
		if flight.image == nil {
			let configuration = UIImage.SymbolConfiguration(pointSize: 60)
			let plane = UIImage(systemName: "airplane", withConfiguration: configuration)!.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
			cell.image.image = plane
			cell.image.contentMode = .center
		} else {
			cell.image.contentMode = .scaleAspectFit
		}
		
		cell.backgroundColor = UIColor.lightGray
		return cell
	}
}
