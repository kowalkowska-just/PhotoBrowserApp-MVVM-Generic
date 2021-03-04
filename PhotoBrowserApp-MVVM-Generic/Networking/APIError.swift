//
//  APIError.swift
//  PhotoBrowserApp-MVVM-Generic
//
//  Created by Justyna Kowalkowska on 04/03/2021.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailed
    case jsonConversionFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Respone Unsuccessful"
        case .jsonParsingFailed:
            return "JSON Parsing Failed"
        case .jsonConversionFailed:
            return "JSON Conversion Failed"
        }
    }
}
