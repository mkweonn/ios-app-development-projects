//
//  FlashcardCell.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/16/23.
//

import SwiftUI

struct FlashcardCell: View {
    // store flashcard contents to be rendered
    let flashcard: Flashcard
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(flashcard.question)
                .font(.title3)
            Text(flashcard.answer)
                .font(.subheadline)
        }
    }
}

struct FlashcardCell_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardCell(flashcard: Flashcard(id: UUID().uuidString, question: "hello?", answer: "bye!", isFavorite: false))
    }
}
