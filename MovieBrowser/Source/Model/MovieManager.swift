//
//  MovieManager.swift
//  MovieBrowser
//
//  Created by Addin Gama Bertaqwa on 28/03/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func didFinishSearch(_ movieManager: MovieManager, searchResult: SearchMovieResponse)
    func didFinishSearchWithError(error: Error)
}

struct MovieManager {
    var delegate: MovieManagerDelegate?
    let baseUrl = "https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3"
    var movies: [Movie] = []
    var currentPage: Int = 1
    var totalPage: Int = 1
    var totalResult: Int = 0
    
    func searchMovies(query: String) {
        let urlString = "\(baseUrl)&page=\(currentPage)&query=\(query)"
        print(urlString)
        performSearch(with: urlString)
    }
    
    func performSearch(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFinishSearchWithError(error: error!)
                }
                
                if let safeData = data {
                    if let results = self.parseSearchJSON(safeData) {
                        self.delegate?.didFinishSearch(self, searchResult: results)
                    }
                   
                }
            }
            task.resume()
        }
    }
    
    func parseSearchJSON(_ searchData: Data) -> SearchMovieResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchMovieResponse.self, from: searchData)
            
            return decodedData
        } catch {
            self.delegate?.didFinishSearchWithError(error: error)
            return nil
        }
    }
    
    
}
