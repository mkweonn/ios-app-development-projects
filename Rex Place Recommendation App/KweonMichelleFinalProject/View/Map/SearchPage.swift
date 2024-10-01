//
//  SearchPage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 12/1/23.
//

import SwiftUI

// represents view that displays search results from Yelp API
// displays UIKit implementation
struct SearchPage: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    
    @State private var searchPlace = ""
    @State private var cityText = ""
    @State private var businesses = [YelpPlace]()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search for or Add a place", text: $searchPlace)
                    // search places as textfield changes
                    .onChange(of: searchPlace) {
                        // calls viewModel function with API
                        search()
                    }
                .multilineTextAlignment(.center)
                
                Image(systemName: "magnifyingglass")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Rectangle().stroke())
            .padding(.bottom, 5)
            
//            HStack {
//                Image(systemName: "mappin.and.ellipse")
            
            // UIKit to have different color text
                CityTextField(text: $cityText)
                    .frame(height: 20)
                    // search places as textfield changes
                    // based on Yelp API, search results display once location is provided
                    .onChange(of: cityText) {
                        // calls viewModel function with API
                        search()
                    }
//            }
//            .padding(8)
//            .frame(maxWidth: .infinity)
//            .background(Rectangle().stroke())
            
            // display search results
            List(businesses) { business in
                HStack {
                    VStack(alignment: .leading) {
                        Text(business.name)
                            .font(.subheadline)
                        Text("\(business.location.address1), \(business.location.city), \(business.location.state)")
                            .font(.caption2)
                    }
                    Spacer()
                    Button {
//                    <<future>>: make it toggle for each individual business and add to profile ex: business.isVisited.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
//                        Image(systemName: isVisited ? "plus.circle.fill" : "plus.circle")
                    }
                    Button {
//                        isBookmarked.toggle()
                    } label: {
                        Image(systemName: "bookmark")
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
    
    // included function here in order to use the parameters and help with code con
    func search() {
        // searches for places
        searchViewModel.searchBusinesses(with: searchPlace, in: cityText) { result in
            DispatchQueue.main.async {
                self.businesses = result ?? []
            }
        }
    }
}

#Preview {
    SearchPage()
}
