//
//  BaseTableViewController.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import UIKit

class BaseTableViewController<T: BaseTableViewCell<U>, U>: UITableViewController {

    var items: [U]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(T.self, forCellReuseIdentifier: "cellID")
        onLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! BaseTableViewCell<U>
        cell.item = items?[indexPath.row]
        return cell
    }

    func onLoad() {
        print("override me onLoad")
    }
}
