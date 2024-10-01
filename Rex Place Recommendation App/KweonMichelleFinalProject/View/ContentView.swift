//
//  ContentView.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        // loads the signup page as first screen
        if !userViewModel.isLoggedIn {
            SignUpPage(userViewModel: userViewModel)
        } else {
            MainTabView(userViewModel: userViewModel)
        }
    }
}

#Preview {
    ContentView()
}
