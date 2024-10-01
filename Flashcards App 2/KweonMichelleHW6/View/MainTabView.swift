//
//  MainTabView.swift
//  KweonMichelleHW6
//
//  Created by Michelle Kweon on 10/23/23.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var flashcardViewModel = FlashcardViewModel()
//    @State var selection = 0
    
    var body: some View {
        TabView() {
            FlashcardPage()
//                .tag(0)
                .tabItem {
                    Label("Question", systemImage: "questionmark")
                }
            
            FlashcardListPage()
                .tabItem {
                    Label("Cards", systemImage: "square.stack.3d.up.fill")
                }
            
            FavoritesFlashcardListPage()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .environmentObject(FlashcardViewModel())
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
