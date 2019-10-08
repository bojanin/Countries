//
//  ViewController.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import UIKit

class CountriesTableViewController: BaseTableViewController<CountryTableViewCell, Country> {

    var resultsSearchController = UISearchController()

    var filteredItems = [Country]()

    override func onLoad() {
        resultsSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            definesPresentationContext = true
            tableView.tableHeaderView = controller.searchBar
            controller.searchBar.placeholder = NSLocalizedString("Search Country Names", comment: "")
            controller.searchBar.showsBookmarkButton = true
            controller.searchBar.setImage(UIImage(named: "sort"), for: .bookmark, state: .normal)
            controller.searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .bookmark)
            return controller
        })()
        Network.shared.download(from: .countries) { [weak self] (countries: [Country]?) in
            self?.items = countries
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country: Country?

        if resultsSearchController.isActive {
            country = filteredItems[indexPath.row]
        } else {
            country = items?[indexPath.row]
        }
        if let country = country {
            let title = NSLocalizedString("Information", comment: "")
            self.resultsSearchController.dismiss(animated: true, completion: nil)
            Alert.alertWithActions(on: self, withTitle: title, message: nil, withStyle: .actionSheet, andActions: createActions(for: country))
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsSearchController.isActive ? filteredItems.count : (items?.count ?? 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as! CountryTableViewCell
        if resultsSearchController.isActive {
            cell.item = filteredItems[indexPath.row]
        } else {
            cell.item = items?[indexPath.row]
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    private func createActions(for item: Country) -> [UIAlertAction] {
        let capital = item.capital == "" ? NSLocalizedString("No capital specified.", comment: "") : NSLocalizedString("Capital: \(item.capital)", comment: "")
        let name = item.name == "" ? NSLocalizedString("No name specified.", comment: "") : NSLocalizedString("\(item.name)", comment: "")
        let gini = item.gini == nil ? NSLocalizedString("No gini specified.", comment: "") : NSLocalizedString("Gini: \(item.gini!)", comment: "")
        let region = item.region == "" ? NSLocalizedString("No region specified.", comment: "") : NSLocalizedString("Region: \(item.region)", comment: "")
        let subregion = item.subregion == "" ? NSLocalizedString("No subregion specified.", comment: "") : NSLocalizedString("Subregion: \(item.subregion)", comment: "")
        let population = NSLocalizedString("Population: \(item.population)", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")

        let nameAction = UIAlertAction(title: name, style: .default, handler: nil)
        let capitalAction = UIAlertAction(title: capital, style: .default, handler: nil)
        let regionAction = UIAlertAction(title: region, style: .default, handler: nil)
        let subregionAction = UIAlertAction(title: subregion, style: .default, handler: nil)
        let giniAction = UIAlertAction(title: gini, style: .default, handler: nil)
        let populationAction = UIAlertAction(title: population, style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)

        return [nameAction, capitalAction, regionAction, subregionAction, giniAction, populationAction, cancelAction]
    }
}
