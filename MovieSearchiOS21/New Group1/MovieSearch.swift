//
//  MovieSeach.swift
//  MovieSearchiOS21
//
//  Created by Xavier on 9/14/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
   
    let results: [MovieSearch]
}

struct MovieSearch: Decodable {
    var movieTitle: String
    var rating: String
    var summary: String
    var imageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case summary = "overview"
        case imageUrlString = "posterURL"
        case movieTitle = "originaltitle"
        case rating = "voteaverage"
    }
}





