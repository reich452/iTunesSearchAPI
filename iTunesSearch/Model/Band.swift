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
    var albumName: String?  // In JSON this is the collectionName 
    let albumPrice: Double? // In JSON this is collectionPrice
    var trackCount: Int?
    var recordImageURL: URL?

}

extension Band {
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case genre = "primaryGenreName"
        case albumName = "collectionName"
        case albumPrice = "collectionPrice"
        case trackCount
        case recrodImageURL = "artworkUrl100"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        genre = try values.decode(String.self, forKey: CodingKeys.genre)
        albumName = try values.decodeIfPresent(String.self, forKey: CodingKeys.albumName)
        albumPrice = try values.decodeIfPresent(Double.self, forKey: CodingKeys.albumPrice)
        trackCount = try values.decodeIfPresent(Int.self, forKey: CodingKeys.trackCount)
        recordImageURL = try values.decode(URL.self, forKey: CodingKeys.recrodImageURL)
    }
}

struct Bands: Decodable {
    let results: [Band]
}
