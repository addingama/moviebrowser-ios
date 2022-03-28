//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Addin Gama Bertaqwa on 28/03/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with movie: Movie) {
        title.text = movie.title
        releaseDate.text = movie.getReleaseDate()
        rating.text = "\(movie.vote_average!)"
    }

}
