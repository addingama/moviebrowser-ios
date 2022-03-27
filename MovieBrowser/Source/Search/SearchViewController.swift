//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        movieManager.delegate = self
    }
    
    @IBAction func goPressed(_ sender: UIButton) {
        triggerSearch()
    }
    
    func triggerSearch () {
        if let query = searchBar.text {
            print(query)
            movieManager.searchMovies(query: query)
        }
    }
    
    func showToast(message: String) {
        let toastWidth = self.view.frame.size.width - 20
        let toastHeight = 50
        let toastXPosition = self.view.frame.size.width/2 - (toastWidth/2)
        let toastYPosition = self.view.frame.size.height-100
        let toastLabel = UILabel(frame: CGRect(x: toastXPosition, y: toastYPosition, width: toastWidth, height: CGFloat(toastHeight)))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
    
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        triggerSearch()
    }
}

//MARK: - MovieManagerDelegate
extension SearchViewController: MovieManagerDelegate {
    func didFinishSearch(_ movieManager: MovieManager, searchResult: SearchMovieResponse) {
        print("search finished, page \(searchResult.page) of \(searchResult.total_pages) with \(searchResult.total_results) movies")
    }
    
    func didFinishSearchWithError(error: Error) {
        DispatchQueue.main.async {
            self.showToast(message: error.localizedDescription)
        }
    }
}

