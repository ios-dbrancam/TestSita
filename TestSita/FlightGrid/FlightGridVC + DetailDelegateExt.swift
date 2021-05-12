import UIKit

extension FlightGridViewController: DetailViewControllerDelegate {
	func selectFavorite(_ flight: Flight) {
		flightDataSource.setFavorite(flight)
		flightsCollection.reloadData()
	}
}
