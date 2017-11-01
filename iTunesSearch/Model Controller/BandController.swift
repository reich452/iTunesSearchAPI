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
    
    
    
    
    private func bandURL(for artistName: String) -> URL {

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        let queryItems = [URLQueryItem(name: "term", value: artistName)]
        components.queryItems = queryItems
        return components.url!
    }
}
