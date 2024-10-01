//
//  RecommendationCell.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI

// represents an individual cell of recommendation on the feed (like Venmo page single transaction)
struct RecommendationCell: View {
    @ObservedObject var userViewModel: UserViewModel
    
//    @State private var isLiked = false
    @State private var isVisited = false
    @State private var isBookmarked = false
    
    let rex: Place
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("ProfilePic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("**USER NAME** visited **\(rex.name)**")
                    .font(.subheadline)
                Text(rex.city)
                    .font(.caption2)
                // <<future>>: add the custom description by a user
                Text("This is a description. Nice place!")
                    .font(.subheadline)
                    .padding(.vertical)
                
                HStack(spacing: 20) {
//                    Button(action: {
//                        isLiked.toggle()
//                    }) {
//                        Image(systemName: isLiked ? "heart.fill" : "heart")
//                            .foregroundColor(isLiked ? Color.red : Color.blue)
//                    }
                    Button(action: {
                        isVisited.toggle()
                        if isVisited {
                            // add place to user recommendationIds
                            userViewModel.addPlace(rex)
                        } else {
                            // remove place to user recommendationIds
                            userViewModel.removePlace(rex)
                        }
                    }) {
                        Image(systemName: isVisited ? "plus.circle.fill" : "plus.circle")
                            .foregroundColor(Color.blue)
                    }
                
                    Button(action: {
                        isBookmarked.toggle()
                        if isBookmarked {
                            // add place to user bookmarkIds
                            userViewModel.addBookMark(rex)
                        } else {
                            // remove place to user bookmarkIds
                            userViewModel.removeBookMark(rex)
                        }
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(Color.blue)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    RecommendationCell(userViewModel: UserViewModel(), rex: Place(id: UUID().uuidString, name: "Location Name", city: "City, State", latitude: 0.0, longitude: 0.0))
}
