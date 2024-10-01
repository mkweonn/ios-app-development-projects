//
//  Place.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import Foundation

// model to represent the Place in a User's recommendation
struct Place: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let city: String
    let latitude: Double
    let longitude: Double
    // isVisited
    // isBookmarked
}

// <<future>>: add descriptions for recommendations
//struct Recommendation : Identifiable, Codable {
//    let id: String
//    let user: String // userID - User.name
//    let place: String // placeID
//    let description: String
//}
