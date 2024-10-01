//
//  FlashcardViewModel.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/10/23.
//

import Foundation
import Combine

class FlashcardViewModel : FlashcardsModel, ObservableObject {
    // array of Flashcard

    @Published var flashcards = [Flashcard]() {
        didSet {
            save()
        }
    }
   
    private var flashcardsFilePath: URL
    
    init() {
        let documentsDirectory = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask).first!
        
//        print(documentsDirectory)
        
        // initialize file path to file
        let filePath = "\(documentsDirectory)/flashcards.json"
        flashcardsFilePath = URL(string: filePath)!
       
        if let loadedFlashcards = load() {
            flashcards = loadedFlashcards
        } else {
            // initialize 5 flashcards
            flashcards = [
                Flashcard(
                    id: UUID().uuidString,
                    question: "What year was USC founded?",
                    answer: "1880",
                    isFavorite: false
                ),
                Flashcard(
                    id: UUID().uuidString,
                    question: "Who is the president of USC?",
                    answer: "Carol Folt",
                    isFavorite: false
                ),
                Flashcard(
                    id: UUID().uuidString,
                    question: "What is the official Mascot of USC?",
                    answer: "Traveler",
                    isFavorite: false
                ),
                Flashcard(
                    id: UUID().uuidString,
                    question: "Which school is USC's biggest rival?",
                    answer: "UCLA",
                    isFavorite: false
                ),
                Flashcard(
                    id: UUID().uuidString,
                    question: "What are USC's school colors?",
                    answer: "Cardinal and Gold",
                    isFavorite: false
                ),
            ]
        }
        
    }
    
    // keep track of current card you are displaying
    @Published var currentIndex : Int = 0 {
        // making sure current index does not go out of bounds
        didSet {
            if currentIndex < 0 && currentIndex >= flashcards.count {
                currentIndex = oldValue
            }
        }
    }
        
    var numberOfFlashcards: Int {
        // number of flashcards in array
        flashcards.count
    }
    
    var currentFlashcard: Flashcard? {
        if flashcards.isEmpty {
            return nil
        }
        // return current flashcard of currentIndex
        return flashcards[currentIndex]
    }

    // @published var
    var favoriteFlashcards: [Flashcard] {
        // .filter return new filtered collection of cards marked as favorite
                return flashcards.filter{$0.isFavorite}
    }

    func randomize() {
        if flashcards.isEmpty {
            return
        }
        
        // randomize current Index within bounds flashcards array
        var randomIndex = Int.random(in: 0..<flashcards.count)
        
        while(randomIndex == currentIndex) {
            randomIndex = Int.random(in: 0..<flashcards.count)
        }
        
        currentIndex = randomIndex
    }

    func next() {
        if currentIndex == flashcards.count - 1 {
            // reach end of array, go back to beginning
            currentIndex = 0
        }
        else {
            // set currentIndex to next
            currentIndex += 1
        }
    }
    
    func previous() {
        if currentIndex == 0 {
            // reach beginning of array, loop back to end of array
            currentIndex = flashcards.count - 1
        } else {
            // decrement current Index by one
            currentIndex -= 1
        }
    }
        
    func flashcard(at index: Int) -> Flashcard? {
        if index < 0 && index >= flashcards.count {
            return nil
        }
        // return flashcard at given index
        return flashcards[index]
    }
    
    func append(flashcard: Flashcard) {
        // insert flashcard at end of array
        flashcards.append(flashcard)
        
//            let end = flashcards.count
//            flashcards[end-1] = flashcard
    }
        
    // Initializes a flashcard at specific index of your flashcards array
    func insert(flashcard: Flashcard, at index: Int) {
        if index >= 0 && index < flashcards.count {
            // add flashcard to specific index
            flashcards.insert(flashcard, at: index)
//            flashcards[index] = flashcard
        }
        // add to end of array if out of bounds
        else {
            flashcards.append(flashcard)
        }
    }
    
    // Removes flashcard at a specific index
    func removeFlashcard(at index: Int) {
        if index < 0 && index >= flashcards.count {
            // ignore if out of bounds
           return
        }
        
        flashcards.remove(at: index)
    }
    
    // Returns an index for a given flashcard
    func getIndex(for flashcard: Flashcard) -> Int? {
        flashcards.firstIndex(of: flashcard)
    }
    
    func update(flashcard: Flashcard, at index: Int) {
        if index < 0 && index >= flashcards.count {
            return
        }
        // update at specific index
        flashcards[index] = flashcard
    }
    
    // Toggles the favorite attribute of your flashcard
    func toggleFavorite() {
        let currentFlashcard = flashcards[currentIndex]
        let newFlashcard = Flashcard(id: currentFlashcard.id, question: currentFlashcard.question, answer: currentFlashcard.answer, isFavorite: !currentFlashcard.isFavorite)
        
        update(flashcard: newFlashcard, at: currentIndex)
//        favoriteFlashcards = flashcards.filter{$0.isFavorite}
    }
    
    // Encode -> Swift Objects -> JSON
      private func save() {
          let encoder = JSONEncoder()

          do {
              // attempt to encodes Swift objects into JSON
              let data = try encoder.encode(flashcards)
              // save to disk
              try data.write(to: flashcardsFilePath)
          } catch {
              print(error)
          }
      }

    // attempts to read from disk and deocdes from JSON into Swift objects
      private func load() -> [Flashcard]? {
          let decoder = JSONDecoder()

          do {
              // read from disk
              let data = try Data(contentsOf: flashcardsFilePath)
              // decodes from JSON into Swift objects
              let flashcards = try decoder.decode(Array<Flashcard>.self, from: data)
              // load array of flashcards from file path
              return flashcards
          } catch {
              print(error)
              return nil
          }
      }
}
