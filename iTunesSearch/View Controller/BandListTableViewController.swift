//
//  BandListTableViewController.swift
//  iTunesSearch
//
//  Created by Nick Reichard on 11/1/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class BandListTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var bands = [Band]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.rowHeight = 150
        
    }
    
    // MARK: - Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        BandController.shared.fetchBand(matching: searchTerm) { (bands) in
            guard let bands = bands else { return }
            self.bands = bands
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bandCell", for: indexPath) as? BandTableViewCell else { return UITableViewCell() }

        let band = self.bands[indexPath.row]
        cell.updateWith(band: band)
        return cell
    }
    
}
