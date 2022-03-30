//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieManager = MovieManager.sharedInstance
    var prevKeyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Movie Search"

        searchBar.delegate = self
        movieManager.delegate = self
    }
    
    @IBAction func goPressed(_ sender: UIButton) {
        triggerSearch()
    }
    
    func triggerSearch () {
        // TODO: use guard let
        if let query = searchBar.text {
            if query != prevKeyword {
                movieManager.setData(page: 1, data: [], totalPage: 1)
            }
            movieManager.searchMovies(query: query)
        }
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO: remove dispatch queue because it's running on main thread
        DispatchQueue.main.async {
            self.movieManager.setData(page: 1, data: [], totalPage: 1)
            self.moviesTable.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        triggerSearch()
    }
}

//MARK: - MovieManagerDelegate
extension SearchViewController: MovieManagerDelegate {
    func didFinishSearch(_ movieManager: MovieManager, searchResult: SearchMovieResponse) {
        self.movieManager.setData(page: searchResult.page, data: searchResult.results, totalPage: searchResult.total_pages)
        self.prevKeyword = self.searchBar.text!
        
        DispatchQueue.main.async {
            self.moviesTable.reloadData()
        }
        
    }
    
    func didFinishSearchWithError(error: Error) {
        DispatchQueue.main.async {
            print(error)
            self.showToast(message: error.localizedDescription)
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 83
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieManager.setSelectedMovie(movie: self.movieManager.movies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movieManager.movies.count - 1 && !self.movieManager.isLastPage {
            self.movieManager.nextPage()
            self.triggerSearch()
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieManager.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie: Movie = self.movieManager.movies[indexPath.row]
        
        movieCell.configure(with: movie)
        
        
        return movieCell
    }
}


//MARK: - UIViewController
extension UIViewController {
    // Just hide table view and show error info label
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
