import UIKit

class FloatButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		tintColor = UIColor.white
		backgroundColor = UIColor(red: 62/255, green: 84/255, blue: 113/255, alpha: 1)
		layer.cornerRadius = 12
		layer.shadowOpacity = 0.4
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize.zero
	}
}
