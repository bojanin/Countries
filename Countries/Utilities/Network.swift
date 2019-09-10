//
//  Network.swift
//  Countries
//
//  Created by Tommy Bojanin on 9/9/19.
//  Copyright © 2019 Bojanin. All rights reserved.
//

import Foundation

class Network {
    static let shared = Network()

    private let session = URLSession.shared

    private let decoder = JSONDecoder()

    /// Reference to the api plist
    private var plist: NSDictionary? {
        if let path = Bundle.main.path(forResource: "API", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }

    /// api endpoints dictionary
    private var endpoints: [String: Any]? {
        return plist?["endpoints"] as? [String: Any]
    }

    /// api keys dictionary
    private var keys: [String: Any]? {
        return plist?["keys"] as? [String: Any]
    }

    /// Returns the usernames dictionary from the API plist
    private var hosts: [String: Any]? {
        return plist?["hosts"] as? [String: Any]
    }

    /// function that retrieves a key given a service
    private func key(forService service: APIServiceType) -> String? {
        return keys?[service.rawValue] as? String
    }

    /// function that retrieves a host for a service
    private func host(forService service: APIServiceType) -> String? {
        return hosts?[service.rawValue] as? String
    }

    ///func that retrieves a endpoint given a service
    private func endpoint(forService service: APIServiceType) -> URL? {
        if let endpoint = endpoints?[service.rawValue] as? String {
            if let url = URL(string: endpoint) {
                return url
            }
        }
        return nil
    }


    func download<T: Decodable>(from type: APIServiceType, onComplete: @escaping ([T]?) -> Void) {
        guard let key = key(forService: type),
            let host = host(forService: type),
            let endpoint = endpoint(forService: type) else {
                print("key, host or endpoint nil: \(#file) \(#function) \(#line)")
                onComplete(nil)
                return
        }

        let headers = [
            "x-rapidapi-host": "\(host)",
            "x-rapidapi-key": "\(key)"
        ]

        let request = NSMutableURLRequest(url: endpoint,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                print("data is nil: \(#file) \(#function) \(#line)")
                print(error.debugDescription, response.debugDescription)
                onComplete(nil)
                return
            }

            do {
                let items = try self.decoder.decode([T].self, from: data)
                onComplete(items)
            } catch {
                print(error)
                print("countries couldnt be decoded: \(#file) \(#function) \(#line)")
                onComplete(nil)
            }
        }).resume()
    }
}
