//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movieManager = MovieManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movieManager.selectedMovie?.title
        releaseLabel.text = movieManager.selectedMovie?.getReleaseDate()
        descriptionLabel.text = movieManager.selectedMovie?.overview
        
        
    }
}
