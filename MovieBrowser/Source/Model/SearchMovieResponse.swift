//
//  SearchMovieResponse.swift
//  MovieBrowser
//
//  Created by Addin Gama Bertaqwa on 30/03/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

struct SearchMovieResponse: Codable {
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [Movie]
}
