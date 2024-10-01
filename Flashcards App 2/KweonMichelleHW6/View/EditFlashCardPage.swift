//
//  EditFlashCardPage.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/15/23.
//

import SwiftUI

struct EditFlashCardPage: View {
    // programmatically dismiss page
    @Environment(\.dismiss) private var dismiss
    // view model to add/edit flashcards
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    // initialize if page has a flashcard to edit. if nill, handling a new flashcard
    private var flashcard: Flashcard?
    
    // store content of the form field for flashcard's question
    @State private var question = ""
    // store content content of the form field for a flashcard's answer
    @State private var answer = ""
    // store content of the form field for a flashcard's isFavorited
    @State private var isFavorite = false
    
    init(flashcard: Flashcard? = nil) {
        self.flashcard = flashcard
        
        _question = State(initialValue: flashcard?.question ?? "")
        _answer = State(initialValue: flashcard?.answer ?? "")
        _isFavorite = State(initialValue: flashcard?.isFavorite ?? false)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                TextField("Question", text: $question)
                TextField("Answer", text: $answer)
                Toggle("Is Favorite?", isOn: $isFavorite)
                Spacer()
            }
            .padding()
            .navigationTitle(flashcard == nil ? "New Card" : "Edit Card")
            .toolbar {
                Button("Save") {
                    // if flashcard != nil
                    if let card = flashcard {
                        // update
                        flashcardViewModel.update(flashcard: Flashcard(id: UUID().uuidString, question: question, answer: answer, isFavorite: isFavorite), at: flashcardViewModel.getIndex(for: card)!)
                    }
                    else {
                        // create
                        flashcardViewModel.append(flashcard: Flashcard(id: UUID().uuidString, question: question, answer: answer, isFavorite: isFavorite))
                    }
                    dismiss()
                }
                .disabled(question.isEmpty || answer.isEmpty)
            }
        }
    }
}

struct EditFlashCardPage_Previews: PreviewProvider {
    static var previews: some View {
        EditFlashCardPage()
    }
}


