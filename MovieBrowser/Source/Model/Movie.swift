import UIKit

class Movie: Codable {
    var id: Int = 0
    var title: String = ""
    var release_date: String = ""
    var poster_path: String = ""
    var overview: String = ""
}

struct SearchMovieResponse: Codable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [Movie]
}
