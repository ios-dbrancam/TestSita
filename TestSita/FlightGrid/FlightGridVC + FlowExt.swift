import UIKit

extension FlightGridViewController: UICollectionViewDelegateFlowLayout
{
	private var itemsPerRow: CGFloat { 3 }
	private var spacing: CGFloat { 1 }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemDimension: CGFloat = (view.frame.width / itemsPerRow) - spacing
		return CGSize(width: itemDimension, height: itemDimension)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		spacing
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		spacing
	}
}
