//
//  CountriesTableView+Ext.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import Foundation
import UIKit

extension CountriesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filteredItems.removeAll(keepingCapacity: false)

        if let searchText = searchController.searchBar.text {
            filteredItems = items?.filter({$0.name.contains(searchText)}) ?? []
            tableView.reloadData()
        }
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let title = NSLocalizedString("Show Total Population", comment: "")
        let population = items?.reduce(0, {$0 + $1.population})
        let populationTitle = NSLocalizedString("\(population ?? 0)", comment: "")
        let populationAction = UIAlertAction(title: title, style: .default) { (_) in
            Alert.present(on: self, withTitle: title, message: populationTitle)
        }

        let sortGiniAction = UIAlertAction(title: NSLocalizedString("Sort By Gini Index", comment: ""), style: .default) { [weak self] (_) in
            guard let self = self else {return}
            self.items = self.items?.sorted(by: { (c1, c2) -> Bool in
                guard let g1 = c1.gini, let g2 = c2.gini else { return false }
                return g1 > g2
            })
        }

        let sortPopulation = UIAlertAction(title: NSLocalizedString("Sort By Population", comment: ""), style: .default) { [weak self] (_) in
            guard let self = self else {return}
            self.items = self.items?.sorted(by: { $0.population > $1.population})
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
        })
        
        Alert.alertWithActions(on: self, withTitle: NSLocalizedString("Information", comment: ""), message: nil, withStyle: .alert, andActions: [populationAction, sortGiniAction, sortPopulation, cancel])
    }
}
