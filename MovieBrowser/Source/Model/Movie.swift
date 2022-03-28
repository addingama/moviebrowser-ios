import UIKit

class Movie: Codable {
    var id: Int = 0
    var title: String = ""
    var release_date: String = ""
    var poster_path: String? = ""
    var overview: String = ""
    
    func getReleaseDate(format: String = "MMMM dd, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: self.release_date) {
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
        
        
        return self.release_date
    }
}

struct SearchMovieResponse: Codable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [Movie]
}
