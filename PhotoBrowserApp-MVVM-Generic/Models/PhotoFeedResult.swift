//
//  PhotoFeedResult.swift
//  PhotoBrowserApp-MVVM-Generic
//
//  Created by Justyna Kowalkowska on 03/03/2021.
//

import Foundation

struct PhotoFeedResult: Codable {
    var total_results: Int
    var page: Int
    var per_page: Int
    var photos: [Photo]
}
