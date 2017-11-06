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
    let artistName: String?
    let genre: String?
    var collectionName: String?  // In JSON this is the collectionName "recordName"
    let recordPrice: Double? // In JSON this is collectionPrice
    var trackCount: Int?
    var recordImageURL: URL?

}

extension Band {
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case genre = "primaryGenreName"
        case collectionName
        case recordPrice = "collectionPrice"
        case trackCount
        case recrodImageURL = "artworkUrl100"
    }
    
    private enum AdditionalName: String, CodingKey {
        case missingName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        genre = try values.decode(String.self, forKey: CodingKeys.genre)
        collectionName = try values.decodeIfPresent(String.self, forKey: CodingKeys.collectionName)
        recordPrice = try values.decode(Double.self, forKey: CodingKeys.recordPrice)
        trackCount = try values.decodeIfPresent(Int.self, forKey: CodingKeys.trackCount)
        recordImageURL = try values.decode(URL.self, forKey: CodingKeys.recrodImageURL)
    }
}

extension KeyedDecodingContainer {
    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
        where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
}

struct Bands: Decodable {
    let results: [Band]
}
