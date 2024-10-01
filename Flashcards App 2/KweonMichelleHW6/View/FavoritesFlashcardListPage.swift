//
//  FavoritesFlashcardListPage.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/16/23.
//

import SwiftUI

struct FavoritesFlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack {
            List(flashcardViewModel.favoriteFlashcards) { flashcard in
                NavigationLink {
                    EditFlashCardPage(flashcard: flashcard)
                } label: {
                    FlashcardCell(flashcard: flashcard)
                }
                
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesFlashcardListPage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesFlashcardListPage()
            .environmentObject(FlashcardViewModel())
    }
}
