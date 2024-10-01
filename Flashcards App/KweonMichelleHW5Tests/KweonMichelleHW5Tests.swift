//
//  KweonMichelleHW5Tests.swift
//  KweonMichelleHW5Tests
//
//  Created by Michelle Kweon on 10/4/23.
//

import XCTest
@testable import KweonMichelleHW5

final class KweonMichelleHW5Tests: XCTestCase {
    
    var viewModel : FlashcardViewModel!
    
    override class func setUp() {
    }
    
    override func setUp() {
        // declare model
        viewModel = FlashcardViewModel()
    }
    
    func testNumberOfFlashcards() {
        XCTAssertEqual(viewModel.numberOfFlashcards, 5)
    }
    
    func testCurrentFlashcard() {
        XCTAssertNotNil(viewModel.currentFlashcard)
    }
    
    func testFavoriteFlashcards() {
        let favoriteFlashcard = viewModel.favoriteFlashcards
        XCTAssertEqual(favoriteFlashcard.count, 0)
        
        viewModel.toggleFavorite()
        
        XCTAssertEqual(viewModel.favoriteFlashcards.count, 1)
    }
    
    func testRandomize() {
        let startIndex = viewModel.currentIndex
        
        viewModel.randomize()
        
        XCTAssertNotEqual(viewModel.currentIndex, startIndex)
    }
    
    func testNext() {
        let startIndex = viewModel.currentIndex
        viewModel.next()
        
        XCTAssertEqual(viewModel.currentIndex, startIndex + 1)
    }
    
    func testPrevious() {
       viewModel.currentIndex = 0
        
        viewModel.previous()
        
        XCTAssertEqual(viewModel.currentIndex, 4)
        
        viewModel.currentIndex = 3
         
        viewModel.previous()
         
        XCTAssertEqual(viewModel.currentIndex, 2)
    }
    
    func testFlashcardAtIndex() {
        let flashcard = viewModel.flashcard(at: 1)
        
        XCTAssertNotNil(flashcard)
        
        XCTAssertEqual(flashcard?.question, "Who is the president of USC?")
    }
    
    func testAppendFlashcard() {
        let initialCount = viewModel.numberOfFlashcards
        let newFlashcard = Flashcard(id: "test", question: "test question", answer: "test answer", isFavorite: false)
        
        viewModel.append(flashcard: newFlashcard)
        
        XCTAssertEqual(viewModel.numberOfFlashcards, initialCount + 1)
    }
    
    func testInsertFlashcard() {
        let initialCount = viewModel.numberOfFlashcards
        let newFlashcard = Flashcard(id: "test", question: "test question", answer: "test answer", isFavorite: false)
        viewModel.insert(flashcard: newFlashcard, at: 2)
        
        XCTAssertEqual(viewModel.flashcard(at: 2)?.question, "test question")
        
        XCTAssertEqual(viewModel.flashcard(at: 2)?.question, "test question")
        XCTAssertEqual(viewModel.numberOfFlashcards, initialCount + 1)
    }
    
    func testRemoveFlashcard() {
        let initialCount = viewModel.numberOfFlashcards
        let index = 0
        viewModel.removeFlashcard(at: index)
        
        XCTAssertEqual(viewModel.numberOfFlashcards, initialCount - 1)
    }
    
    
    func testGetIndexForFlashcard() {
        let flashcard = viewModel.flashcards[3]
        let index = viewModel.getIndex(for: flashcard)
        
        XCTAssertEqual(index, 3)
    }
    
    func testUpdateFlashcard() {
        let newFlashcard = Flashcard(id: "test", question: "test question", answer: "test answer", isFavorite: false)
        
        viewModel.update(flashcard: newFlashcard, at: 2)
        
        let updatedFlashcard = viewModel.flashcard(at: 2)
        
        XCTAssertNotNil(updatedFlashcard)
        XCTAssertEqual(updatedFlashcard?.question, "test question")
        XCTAssertEqual(updatedFlashcard?.answer, "test answer")
        XCTAssertEqual(viewModel.flashcard(at: 2)?.question, "test question")
    }
    
    func testToggleFavorite() {
        let initialFavorite = viewModel.currentFlashcard?.isFavorite ?? false
        
        viewModel.toggleFavorite()
        
        XCTAssertNotEqual(viewModel.currentFlashcard?.isFavorite ?? false, initialFavorite)
       
    }
}
