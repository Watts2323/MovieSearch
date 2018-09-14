//
//  MovieSearchTableViewCell.swift
//  MovieSearchiOS21
//
//  Created by Xavier on 9/14/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: MovieSearch? {
        didSet{
            
        }
    }
    
    func updateView() {
        if let movieSearch = movie {
            MovieSearchController.fetchImages(with: (movie?.imageUrlString)!) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
    

}
