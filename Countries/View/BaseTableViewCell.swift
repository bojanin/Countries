//
//  BaseTableViewCell.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import Foundation
import UIKit


class BaseTableViewCell<U>: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var item: U? {
        didSet {
            render()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func render() {
        fatalError("FILL ME OUT")
    }
}
