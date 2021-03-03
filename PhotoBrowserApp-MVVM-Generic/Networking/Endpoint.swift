//
//  Endpoint.swift
//  PhotoBrowserApp-MVVM-Generic
//
//  Created by Justyna Kowalkowska on 03/03/2021.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var query: String { get }
}

extension Endpoint {
    var authHeader: String {
        return Key.key
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base) ?? URLComponents()
        components.path = path
        components.query = query
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url ?? URL(string: "https://www.google.com")!
        var request = URLRequest(url: url)
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        return request
    }
}
