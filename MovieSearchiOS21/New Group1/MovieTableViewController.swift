//
//  MovieTableViewController.swift
//  MovieSearchiOS21
//
//  Created by Xavier on 9/14/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    var movieSearches: [MovieSearch] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieSearches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MovieSearchTableViewCell
        
        let movieSearch = movieSearches[indexPath.row]
        cell.movie = movieSearches[indexPath.row]
        MovieSearchController.fetchImages(with: movieSearch.imageUrlString!) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        MovieSearchController.fetchMovies(with: searchText) { (movieSearches) in
            guard let fetchMovies = movieSearches else { return }
            self.movieSearches = fetchMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
