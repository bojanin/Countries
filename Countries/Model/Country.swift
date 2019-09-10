//
//  Country.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let capital: String
    let population: Int
    let gini: Double?
    let subregion: String
}
