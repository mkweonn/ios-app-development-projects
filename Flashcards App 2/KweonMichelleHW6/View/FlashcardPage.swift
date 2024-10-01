//
//  FlashcardPage.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/23/23.
//

import SwiftUI

// app background color RGB
let backgroundColor = Color(
    red: 173/255,
    green: 216/255,
    blue: 230/255
)

// x and y offset when user interacts with a flashcard
let OFFSET_X = 300.0
let OFFSET_Y = 900.0

struct FlashcardPage: View {
    // store data used by view and rerender when @Published gets updated
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    // keep track of whether a question or answer is currently being displayed
    @State var isShowingQuestion = true
    // target state x position of main view for animation
    @State var offsetX = 0.0
    // target state y position of main view for animation
    @State var offsetY = 0.0
    // target state visibility of the main view for animation
    @State var isHidden = false
    @State var starIsHidden = false
    
    // computed properties
    var title: String {
        if let currentFlashcard = flashcardViewModel.currentFlashcard {
            // return question or answer of current flashcard
            return isShowingQuestion ? currentFlashcard.question : currentFlashcard.answer
        }
        else {
            // if nil
            return ""
        }
    }
    
    var isFavorite: Bool {
        flashcardViewModel.currentFlashcard?.isFavorite ?? false
    }
    
    // methods

    // invoked when user single taps - move card vertically and display random flashcard
    func showRandomFlashCard() {
        withAnimation(.linear(duration: 1.0)) {
            // move card to top edge of the screen
            offsetY = -1 * OFFSET_Y
            // hide card
            isHidden = true
            starIsHidden = true
        }

        withAnimation(.linear.delay(1.0)) {
            // move card to bottom edge of the screen
            offsetY = OFFSET_Y
            // ensure it’s showing a question
            isShowingQuestion = true

            // change flashcard
            flashcardViewModel.randomize()
        }

        withAnimation(.easeInOut(duration: 0.5).delay(1.5)) {
            // move card to center of the screen
            offsetY = 0.0
            // set `isHidden` property
            isHidden = false
            starIsHidden = false
        }
    }
    
    // invoked when user double taps - fade in and out, toggle question and answer
    func toggleQuestionAnswer() {
        withAnimation {
            isShowingQuestion.toggle()
        }
    }
    
    // invoked when user swipes left
    func showNextCard() {
        withAnimation(.linear(duration: 1.0)) {
            // move card to left edge of the screen
            offsetX = -1 * OFFSET_X
            // hide card
            isHidden = true
            starIsHidden = true
        }
        
        withAnimation(.linear.delay(1.0)) {
            // move card to right edge of the screen
            offsetX = OFFSET_X
            // ensure it’s showing a question
            isShowingQuestion = true
            
            // change flashcard
            flashcardViewModel.next()
        }
      
        withAnimation(.easeInOut(duration: 0.5).delay(1.5)) {
            // move card to center of the screen
            offsetX = 0.0
            // set `isHidden` property
            isHidden = false
            starIsHidden = false
        }
    }
    
    // invoked when user swipes right
    func showPreviousCard() {
        withAnimation(.linear(duration: 1.0)) {
            // move card to right edge of the screen
            offsetX = OFFSET_X
            // hide card
            isHidden = true
            starIsHidden = true
        }
 
        withAnimation(.linear.delay(1.0)) {
            // move card to left edge of the screen
            offsetX = -OFFSET_X
            // ensure it’s showing a question
            isShowingQuestion = true
            
            // change flashcard
            flashcardViewModel.previous()
        }
    
        withAnimation(.easeInOut(duration: 0.5).delay(1.5)) {
            // move card to center of the screen
            offsetX = 0.0
            // set `isHidden` property
            isHidden = false
            starIsHidden = false
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(isShowingQuestion ? Color.black : Color.blue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .onTapGesture(count: 2) {
                // double tap
                toggleQuestionAnswer()
            }
            // on startup, display a random flashcard
            .onAppear{
                flashcardViewModel.randomize()
            }
            .onTapGesture {
                // single tap
                showRandomFlashCard()
            }
            .opacity(isHidden ? 0 : 1)
            .offset(x: offsetX, y: offsetY) // define x and y position of the view
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    print(value.translation)
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        print("left swipe") // show next card here
                        showNextCard()
                    case (0..., -30...30):
                        print("right swipe") // show previous card here
                        showPreviousCard()
                    case (-100...100, ...0):
                        print("up swipe")
                    case (-100...100, 0...):
                        print("down swipe")
                    default:
                        print("no clue")
                    }
                }
            )
            .padding()
           
            HStack {
                Spacer()
                Button(action: {
                    flashcardViewModel.toggleFavorite()
                }) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 48))
                        .tint(isFavorite ? Color.yellow : Color.gray)
                        .opacity(starIsHidden ? 0 : 1)
                        .padding()
                }
                .padding()
            }
        }
    }
}

struct FlashcardPage_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardPage()
            .environmentObject(FlashcardViewModel())
    }
}
