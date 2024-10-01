//
//  Flashcard.swift
//  KweonMichelleHW5
//
//  Created by Michelle Kweon on 10/4/23.
//

import Foundation

struct Flashcard : Hashable, Identifiable {
    // storing the unique identifier for a flashcard
    let id: String
    // storing the flashcard’s question
    let question: String
    // storing the flashcard’s answer
    let answer: String
    // telling the user if this is a favorite flashcard
    let isFavorite: Bool
    
    static func == (lhs: Flashcard, rhs: Flashcard) -> Bool {
        return lhs.question == rhs.question && lhs.answer == rhs.answer && lhs.isFavorite == rhs.isFavorite
        // lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(question)
           hasher.combine(answer)
           hasher.combine(isFavorite)
       }
}
