//
//  Flashcard.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/10/23.
//

import Foundation

struct Flashcard : Hashable, Identifiable, Codable {
    // storing the unique identifier for a flashcard
    let id: String
    let question: String
    let answer: String
    // telling the user if this is a favorite flashcard
    let isFavorite: Bool
    
    static func == (lhs: Flashcard, rhs: Flashcard) -> Bool {
        return lhs.question == rhs.question &&
        lhs.answer == rhs.answer &&
        lhs.isFavorite == rhs.isFavorite
        // lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(question)
           hasher.combine(answer)
           hasher.combine(isFavorite)
       }
}
