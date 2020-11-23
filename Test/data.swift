//
//  Subway.swift
//  Test
//
//  Created by 정수범 on 2020/11/20.
//

import Foundation

struct Root: Codable {
    var results: [SearchResult]
    var status: String
}

struct SearchResult: Codable {
    var business_status: String
    var geometry: Geometry
    var icon: String
    var name: String
    var photos: [Photo]
    var place_id: String
    var plus_code: EveryCode
    var rating: Double
    var reference: String
    var scope: String
    var types: [String]
    var id: String
    var user_ratings_total: Int
    var vicinity: String
    
}

struct Geometry: Codable {
    var location: Location
    var viewport: Eastwest
}

struct Location: Codable {
    var lat: Double
    var lng: Double
}

struct Eastwest: Codable {
    var northeast: Location
    var southwest: Location
}

struct Photo: Codable {
    var height: Int
    var html_attributions: [String]
    var photoReference: String
    var width: Int
}

struct EveryCode: Codable {
    var compound_code: String
    var global_code: String
}
