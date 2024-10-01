//
//  FeedPage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represents the feed of all the user + followers recent recommendations
struct FeedPage: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        // <<future>>: navigation path when select user or location name
        VStack(alignment: .leading) {
           Text("**Feed**")
                .font(.title)
                .padding()
    
            Divider()
                .background(Color.black)
                .frame(height: 1)
            
            // displaying dummy data of place recommendations
            List(userViewModel.feedList) { recommendation in
                RecommendationCell(userViewModel: userViewModel, rex: recommendation)
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    FeedPage(userViewModel: UserViewModel())
}
