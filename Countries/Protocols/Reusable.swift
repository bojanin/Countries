//
//  Reusable.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/11/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import Foundation

protocol Reusable {
   static var reuseIdentifier: String { get }
}


extension Reusable {
    /// Reuse identifier implementation so you dont have to manually do it.
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
