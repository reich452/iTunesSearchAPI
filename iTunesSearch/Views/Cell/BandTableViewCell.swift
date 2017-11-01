//
//  BandTableViewCell.swift
//  iTunesSearch
//
//  Created by Nick Reichard on 11/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class BandTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var recordTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var recordPriceLabel: UILabel!
    
    
    // MARK: - Main
    
    func updateWith(band: Band) {
        recordTitleLabel.text = band.recordTitle
        artistNameLabel.text = band.artistName
        genreLabel.text = band.genre
        trackCountLabel.text = "Songs: \(band.trackCount)"
        recordPriceLabel.text = "$ \(band.recordPrice)"
        
        BandController.shared.fetchImage(band: band) { (image) in
            
            DispatchQueue.main.async {
                self.recordImageView.image = image
            }
        }
    }
}
