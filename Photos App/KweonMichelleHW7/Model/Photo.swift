//
//  Photo.swift
//  KweonMichelleHW7
//
//  Created by Michelle Kweon on 10/31/23.
//

import Foundation

struct PhotoUrl : Decodable {
    // represents a base image URL with just the photo path
    let raw: String
    // stores photo's full image URL in jpg format
    let full: String
    // represents a photo in jpg format with a width of 1080 pixels
    let regular: String
    // represents a photo in jpg format with a width of 400 pixels
    let small: String
    // represents a photo in jpg format with a width of 200 pixels
    let thumb: String
}

struct Photo: Decodable, Hashable { // identifier
    // store photo's identifier
    let id: String
    // store all the photo image urls
    let urls: PhotoUrl
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
        // && lhs.urls == rhs.urls
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
//            hasher.combine(urls)
        }
}
