import UIKit

class DetailViewController: UIViewController
{
	//MARK: - Outlets
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var countryLabel: UILabel!
	@IBOutlet var activeLabel: UILabel!
	
	//MARK: - Variables
	var flight: Flight!
	var image: UIImage?
	var delegate: DetailViewControllerDelegate?
	
	//MARK: - View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = flight.name
		
		imageView.image = image
		
		nameLabel.text = flight.name
		countryLabel.text = flight.country
		activeLabel.text = flight.isActive ? "Yes" : "No"
	}
	
	//MARK: - Actions
	@IBAction func addFlightToFavorites(_ sender: FloatButton) {
		flight.isFavorite = true
		navigationController?.popViewController(animated: true)
		delegate?.selectFavorite(flight)
	}
}
