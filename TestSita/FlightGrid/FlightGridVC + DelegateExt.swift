import UIKit

extension FlightGridViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		let flight = flightDataSource.flightsToDisplay[indexPath.row]
		store.fetchImage(for: flight) { result in
			guard case let .success(image) = result else { return }
			if let cell = collectionView.cellForItem(at: indexPath) as? FlightCell {
				cell.image.image = image
			}
		}
	}
}
