//
//  MovieSearchController.swift
//  MovieSearchiOS21
//
//  Created by Xavier on 9/14/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation
import UIKit


class MovieSearchController {
    
    
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/search/movie")!
    static let posterURL = URL(string:"http://image.tmdb.org/t/p/w500/")
    
    
    //Mark: -Fetch Function
    static func fetchMovies(with searchTerm: String, completion: @escaping (([MovieSearch]?) -> Void)) {
        
        //step 1- contruct url
        guard let url = baseUrl else { completion(nil); return}
        
//       url.appendPathComponent("v1")
//       url.appendPathComponent("cards")
        
        //create components since we have to add a query item
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        //cREATE OUR QUERY ITEM
        let searchTermQueryItem = URLQueryItem(name: "movie", value: searchTerm)
        components?.queryItems = [searchTermQueryItem]
        
        //step 2 - Build url request
        guard let requestUrl = components?.url else { completion(nil); return }
        
        //request not necessary default is GET
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //Data task + resume
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error in \(error) \(error.localizedDescription) ")
                completion(nil); return
            }
            
            //unwrap data\
            guard let data = data else { completion(nil);return }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let cards = topLevelDictionary.cards
                completion(cards)
            } catch let error {
                print("There was an error decoding cards: \(error.localizedDescription)")
                completion(nil);return
            }
            }.resume()
    }
    
    static func fetchImages(with imageUrlAsString: String, completion: @escaping (UIImage?) -> Void) {
        
        //URL
        guard let imageURL = URL(string: imageUrlAsString) else { completion(nil) ; return }
        
        //dataTask and resume
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("There was an error getting pokemon image \(error) ; \(error.localizedDescription) ")
                completion(nil);return
            }
            
            guard let data = data else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
            
            }.resume()
        
    }
    
    
    
    
}







