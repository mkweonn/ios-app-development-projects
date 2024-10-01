//
//  YelpPlace.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/30/23.
//

import Foundation

// models to represent the restaurant and places grabbed from YelpAPI search
// <<future>>: combine/connect to Place model
struct YelpPlace: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let location: Location
//    var isVisited: Bool
//    var isBoookmarked: Bool
    
    static func == (lhs: YelpPlace, rhs: YelpPlace) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.location == rhs.location
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// represent more specific attributes of YelpPlace
struct Location: Codable, Equatable {
    let address1: String
    let city: String
    let state: String
}

// hold all the YelpPlaces from API read
struct SearchResponse: Codable {
    let businesses: [YelpPlace]?
}
