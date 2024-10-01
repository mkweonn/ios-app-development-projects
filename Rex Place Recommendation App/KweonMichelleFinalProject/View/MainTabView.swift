//
//  MainTabView.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represents the bottom tab bar
struct MainTabView: View {
    @ObservedObject var userViewModel: UserViewModel
    @StateObject var mapViewModel = MapViewModel()

    // <<future>>: add border to top of tab
    var body: some View {
        TabView() {
            // page that shows followers recommendations
            FeedPage(userViewModel: userViewModel)
                .tabItem {
                    // <<future>>: remove text
                    Label("Home", systemImage: "house")
                }
            // page that has map and pins of followers recommendations and search bar
            MapPage(mapViewModel: mapViewModel, userViewModel: userViewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            // page that shows users own lists
            ProfilePage(userViewModel: userViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainTabView(userViewModel: UserViewModel())
}
