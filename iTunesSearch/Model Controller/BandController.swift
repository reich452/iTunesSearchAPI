//
//  BandController.swift
//  iTunesSearch
//
//  Created by Nick Reichard on 11/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class BandController {
    static let shared = BandController()
    
    let baseUrl = URL(string: "https://itunes.apple.com/search?")!
    
    func fetchBand(matching searchTerm: String, completion: @escaping ([Band]?) -> Void) {
        let url = bandURL(for: searchTerm)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                let jsonDecoder = JSONDecoder()
                
                if let error = error {
                    print("Error getting back json \(error.localizedDescription) \(#file) \(#function)")
                    completion([])
                    return
                }
                guard let data = data else {
                    print("Problem getting data")
                    completion([]); return }
                
                let bands = try jsonDecoder.decode(Bands.self, from: data)
                completion(bands.results)
                
            } catch let error {
                print("Either no data was returned, or data was not serialized \(error.localizedDescription)")
                completion([])
                return
            }
            
            }.resume()
    }
    
    // TODO: - Fetch Image 
    
    
    
    private func bandURL(for artistName: String) -> URL {
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        let queryItems = [URLQueryItem(name: "term", value: artistName)]
        components.queryItems = queryItems
        return components.url!
    }
}
