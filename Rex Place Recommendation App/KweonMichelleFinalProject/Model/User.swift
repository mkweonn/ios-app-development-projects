//
//  User.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import Foundation

// model to represent the user and its data (ex: its login info and place recommendations)
struct User : Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let recommendationIds: [String] // holds Place IDs
    let bookmarkIds: [String] // holds Place IDs

    // <<future>>: add these attributes
    // let followers
    // let following
    // let profilePic
}



