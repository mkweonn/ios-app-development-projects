//
//  FlashcardListPage.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/16/23.
//

import SwiftUI

struct FlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack {
            List($flashcardViewModel.flashcards, editActions: .delete) { $flashcard in
                NavigationLink {
                    EditFlashCardPage(flashcard: flashcard)
                } label: {
                    FlashcardCell(flashcard: flashcard)
                }
                
            }
            .navigationTitle("Flashcards")
            .toolbar {
                NavigationLink {
                    EditFlashCardPage()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    struct FlashcardListPage_Previews: PreviewProvider {
        static var previews: some View {
            FlashcardListPage()
                .environmentObject(FlashcardViewModel())
        }
    }
}
