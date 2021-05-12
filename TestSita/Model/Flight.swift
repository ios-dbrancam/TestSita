import Foundation

struct Flight: Codable
{
	let id: String
	let name: String
	let country: String
	let image: String?
	private let active: String
	var isFavorite: Bool?
	
	var isActive: Bool { active == "Y" ? true : false }
}
