//
//  Artist.swift
//  iTunesSearch
//
//  Created by Nick Reichard on 11/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

struct Band: Decodable {
    
    // MARK: - Properties
    let artistName: String
    let genre: String
    let recordTitle: String    // In JSON this is the collectionName
    let recordPrice: Double // In JSON this is collectionPrice
    let trackCount: Int
    var recordImageURL: URL

}

extension Band {
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case genre = "primaryGenreName"
        case recordTitle = "collectionName"
        case recordPrice = "collectionPrice"
        case trackCount
        case recrodImageURL = "artworkUrl100"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        genre = try values.decode(String.self, forKey: CodingKeys.genre)
        recordTitle = try values.decode(String.self, forKey: CodingKeys.recordTitle)
        recordPrice = try values.decode(Double.self, forKey: CodingKeys.recordPrice)
        trackCount = try values.decode(Int.self, forKey: CodingKeys.trackCount)
        recordImageURL = try values.decode(URL.self, forKey: CodingKeys.recrodImageURL)
    }
}

struct Bands: Decodable {
    let results: [Band]
}
