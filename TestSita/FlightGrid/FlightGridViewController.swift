import UIKit

class FlightGridViewController: UIViewController {
	//MARK: - Outlets
	@IBOutlet var flightsCollection: UICollectionView!
	@IBOutlet var exitSearchButton: FloatButton!
	
	//MARK: - Variables
	var store: FlightStore!
	let flightDataSource = FlightDataSource()
	var isSearchMode = false {
		didSet {
			exitSearchButton.isHidden = !isSearchMode
		}
	}
	
	//MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		flightsCollection.dataSource = flightDataSource
		flightsCollection.delegate = self
		
		loadData()
	}
	
	//MARK: - Actions
	@IBAction func searchFlight(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Search flight by name", message: nil, preferredStyle: .alert)
		alert.addTextField(configurationHandler: nil)
		alert.addAction(UIAlertAction(title: "SEARCH", style: .default) { _ in
			guard let textField = alert.textFields?[0], let inputStr = textField.text else { return }
			self.flightDataSource.setFilter(inputStr)
			self.flightsCollection.reloadData()
			self.isSearchMode = true
		})
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(alert, animated: true, completion: nil)
	}
	
	@IBAction func removeFilter(_ sender: UIButton) {
		isSearchMode = false
		flightDataSource.removeFilter()
		flightsCollection.reloadData()
	}
	
	//MARK: - Functions
	private func loadData() {
		store.fetchFlights() { result in
			switch result {
			case .success(let flights):
				self.flightDataSource.updateFlights(flights)
				FlightPersistance.saveToFile(flights)
				
			case .failure(_):
				self.flightDataSource.updateFlights(FlightPersistance.loadPersistanceData())
			}
			
			self.flightsCollection.reloadData()
			
		}
	}
	
	
	//MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "showDetailSegue" :
			guard let selectedIndexPath = flightsCollection.indexPathsForSelectedItems?.first,
				  let selectedCell = flightsCollection.cellForItem(at: selectedIndexPath) as? FlightCell else { return }
			
			let flight = flightDataSource.flightsToDisplay[selectedIndexPath.row]
			guard let destinationVC = segue.destination as? DetailViewController else { return }
			destinationVC.flight = flight
			destinationVC.image = selectedCell.image.image
			destinationVC.delegate = self
			
		default:
			fatalError("Unkown segue ID")
		}
	}
}
