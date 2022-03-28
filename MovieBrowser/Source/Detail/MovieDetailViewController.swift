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
    
    override func viewWillLayoutSubviews() {
        descriptionLabel.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieManager.selectedMovie?.title
        let formattedDate = movieManager.selectedMovie?.getReleaseDate(format: "d/MM/yyyy")
        releaseLabel.text = "Release Date: \(formattedDate ?? "-")"
        descriptionLabel.text = movieManager.selectedMovie?.overview
        posterImage.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w500\(movieManager.selectedMovie?.poster_path ?? "")")
        
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
            guard let url = URL(string: URLAddress) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                            self?.image = loadedImage
                    }
                }
            }
        }
}
