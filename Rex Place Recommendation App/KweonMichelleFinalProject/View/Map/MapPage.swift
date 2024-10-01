//
//  MapPage.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

// represents the map view and the pins associated with recommended places
struct MapPage: View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var userViewModel: UserViewModel

    // starting location
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7804, longitude: -122.4129),
        span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.05))
    @State private var isVisited = false
    @State private var isBookmarked = false
    
    // dummy data for the one location "selected" at the bottom
    let blueBottle =  Place(
        id: UUID().uuidString,
        name: "Blue Bottle Coffee",
        city: "San Francisco, CA",
        latitude: 0.0,
        longitude: 0.0
    )

    // @StateObject var locationManager = LocationManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    // link to view to search for a place
                    SearchPage()
                } label: {
                    Text("Search for or Add a place")
                    Image(systemName: "magnifyingglass")
                }
                .foregroundColor(Color.blue)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Rectangle().stroke())
                .padding()
                
                ZStack(alignment: .bottom) {
                    // display map and pins (dummy data)
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: places)
                    { location in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(
                            latitude: location.latitude, longitude: location.longitude
                            )) {
                            // represent individual places users recommend
                            Image("MapProfilePic")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 25/10))
                                .shadow(radius: 10)
                        }
                    }
                    HStack {
                        Spacer()
                        // displays users current location
                        LocationButton(.currentLocation) {
                            // gets the users current location
                            mapViewModel.request()
                            if let lastLocation =
                                // sets it in view
                                mapViewModel.lastLocation {
                                region.center = lastLocation.coordinate
                            }
                        }
                        .cornerRadius(20)
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                    }
                    .padding()
                }
                
                // <<future>>: changes based on user clicking on a specific pin
                HStack(spacing: 7) {
                    Image(systemName: "mappin")
                    VStack(alignment: .leading) {
                        Text("**\(blueBottle.name)**")
                            .font(.subheadline)
                        Text("315 Linden St")
                            .font(.caption2)
                        Text("\(blueBottle.city)")
                            .font(.caption2)
                    }
                    Spacer().frame(width: 90)
                    
                    Button(action: {
                        isVisited.toggle()
                        if isVisited {
                            // add to recommendation list in profile page
                            userViewModel.addPlace(blueBottle)
                        } else {
                            // remove
                            userViewModel.removePlace(blueBottle)
                        }
                    }) {
                        Image(systemName: isVisited ? "plus.circle.fill" : "plus.circle")
                    }
                    Button(action: {
                        isBookmarked.toggle()
                        if isBookmarked {
                            // add to want to try list in profile page
                            userViewModel.addBookMark(blueBottle)
                        } else {
                            userViewModel.removeBookMark(blueBottle)
                        }
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 5)
            }
        }
    }
}

// dummy data for map pins
let places = [
    Place(id: UUID().uuidString, name: "Blue Bottle Coffee", city: "San Francisco, CA", latitude: 37.77771116711186,
          longitude: -122.42329976194601),
    Place(id: UUID().uuidString, name: "The Waterfront Restaurant", city: "San Francisco, CA", latitude: 37.79946667825976, longitude: -122.39727615168742),
    Place(id: UUID().uuidString, name: "San Francisco Museum of Modern Art", city: "San Francisco, CA", latitude: 37.7860204743075, longitude: -122.4010144338495),
    Place(id: UUID().uuidString, name: "Mazarine Coffee", city: "San Francisco, CA", latitude: 37.78768755493647, longitude: -122.40403204588956),
    Place(id: UUID().uuidString, name: "La Note", city: "Berkeley, CA", latitude: 37.86663418825118, longitude: -122.26725614816571),
    Place(id: UUID().uuidString, name: "Marugame Udon", city: "Berkeley, CA", latitude: 37.87358905545964, longitude: -122.26834191300014)
]

#Preview {
    MapPage(mapViewModel: MapViewModel(), userViewModel: UserViewModel())
}
