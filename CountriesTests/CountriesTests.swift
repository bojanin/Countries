//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import XCTest
@testable import Countries


class CountriesTests: XCTestCase {

    func testApiDecoding() {
        let decodableExpectation = expectation(description: "All 250 countries are decoded correctly.")
        let notNilCountries = expectation(description: "The returned Countries array is not nil.")

        Network.shared.download(from: .countries) { (countries: [Country]?) in
            guard let countries = countries else {
                return
            }
            notNilCountries.fulfill()

            if countries.count == 250 {
                decodableExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
