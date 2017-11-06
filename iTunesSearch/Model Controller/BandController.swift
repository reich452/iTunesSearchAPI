//
//  BandController.swift
//  iTunesSearch
//
//  Created by Nick Reichard on 11/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

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
                print("Either no data was returned, or data was not serialized \(error) + \(error.localizedDescription)")
                completion([])
                return
            }

            }.resume()
    }
    
    func fetchImage(band: Band, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = band.recordImageURL else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            if let error = error {
                print("\(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Cannot get image data")
                completion(nil); return
                
            }
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
   
    
    // TODO: - Fetch Image 
    
    private func bandURL(for artistName: String) -> URL {
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        let queryItems = [URLQueryItem(name: "term", value: artistName),
                          URLQueryItem(name: "lang", value: "en_us")]
        components.queryItems = queryItems
        return components.url!
    }
}
