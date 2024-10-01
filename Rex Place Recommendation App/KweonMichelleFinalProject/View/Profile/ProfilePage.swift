//
//  ProfilePage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI
import PhotosUI

// represents a user profile and their recommendations and places they want to visit through location cells
struct ProfilePage: View {
    @ObservedObject var userViewModel: UserViewModel
    
    // tab selection
    @State private var selection = 0
    // PhotoKit implementation
    @State private var profileItem: PhotosPickerItem?
    // default pic when not selected a profile pic
    @State private var profilePic: Image? = Image("ProfilePic")
    
    // current user
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
//        print(userViewModel.currUser)
    }
    
    var body: some View {
        VStack {
            VStack(spacing:8) {
                Text("**\(userViewModel.currUser?.name ?? "User Name")**")
    
                if let profilePic {
                    profilePic
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
                // PhotoKit framework to select profile pic from library
                //<<future>>: picture data persistence
                    PhotosPicker(selection: $profileItem, matching: .images, photoLibrary: .shared()) {
                        Text("Edit Profile Picture")
                            .frame(width: 100)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue)
                            )
                            .font(.caption2)
                    }
                    Button(action: {
                        // clears currently logged in and goes back to onboarding page
                        userViewModel.signOut()
                    }) {
                        Text("sign out")
                            .font(.caption2)
                    }
            }
            // set profile picture
            .onChange(of: profileItem ) {
                Task {
                    if let data = try? await profileItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            profilePic = Image(uiImage: uiImage)
                            return
                        }
                    }
                    print("Failed")
                }
            }
            
            HStack {
                Spacer()
                VStack {
                    // <<future>>: NavigationLink to list of followers
                    Text("followers")
                        .font(.caption2)
                    Text("**50**")
                        .font(.footnote)
                }
                Spacer()
                VStack {
                    // <<future>>: NavigationLink to list of following
                    Text("following")
                        .font(.caption2)
                    Text("**50**")
                        .font(.footnote)
                }
                Spacer()
            }
            .padding()
            
            Picker("Tabs", selection: $selection) {
                Text("my list").tag(0)
                Text("want to visit").tag(1)
            }
            .pickerStyle(.segmented)
            
            // display user's recommendation and bookmarks in a list
            List {
                 if selection == 0 {
                     ForEach($userViewModel.rex, editActions: .delete) { $place in
                         LocationCell(location: place)
                     }
                 } else {
                     ForEach($userViewModel.bookmarkList, editActions: .delete) { $place in
                         LocationCell(location: place)
                     }
                 }
             }
             .listStyle(PlainListStyle())
            Spacer()
        }
        .padding()
    }
}

// <<future>>: add filter for cities
//@State var places[Place]
//@State var filteredPlaces[Place]
//@State var city: City
//VStack {
//    List(filteredPlaces)
//} .onChange(city) {
//    filteredPlaces = places...
//}

#Preview {
    ProfilePage(userViewModel: UserViewModel())
}
