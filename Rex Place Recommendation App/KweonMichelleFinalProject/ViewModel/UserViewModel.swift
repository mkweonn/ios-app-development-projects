//
//  UserViewModel.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// logic to handle user related tasks
// implementation of firebase auth and console logic as well as dummy data and other functions to a users recommendation
@MainActor
class UserViewModel: ObservableObject {
    @Published var currUser: User?
    @Published var isLoggedIn = false
    
    @Published var rex = [Place]() // profile page
    @Published var bookmarkList = [Place]() // profile page
    @Published var feedList = [Place]() // feed page
    
    private let db = Firestore.firestore()
    
    // -- User Authentication
    
    // sign up through Firebase
    func signUp(name: String, email: String, password: String, completion: @escaping () -> Void) {
        // added completion handler to properly set isLogged in after signup
        Task {
            do {
                // create user in database
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                
                // create user object to be used in app
                let newUser = User(id: authResult.user.uid, name: name, email: email, password: password, recommendationIds: [], bookmarkIds: [])
                
                // make a document to store data of those user objects and their attributes
                let usersCollection = db.collection("users")
                do {
                    // add matching user data to collection
                    try usersCollection.addDocument(from: newUser)
                    // set current user to use throughout app
                    currUser = newUser
    
                    completion()
                } catch {
                    print(error) // error adding document to firebase
                }
            } catch {
                print(error) // error creating user with firebase
            }
        }
    }

    // login through Firebase
    func login(email: String, password: String, completion: @escaping () -> Void) {
        Task {
            do {
                // sign in with auth info
                try await Auth.auth().signIn(withEmail: email, password: password)
            
                // get the user info matching the authentication
                await fetchUserData()
                // get its place recommendations
                getPlaces()

                // <<future>>: get bookmarked places
                
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    // sign out through Firebase
    func signOut() {
        do {
            try Auth.auth().signOut()
            currUser = nil
            // go back to main page
            isLoggedIn = false
            // reset
            rex.removeAll()
        } catch {
            print(error)
        }
    }
    
    // -- User data
    
    // gets the user data from Firebase
    func fetchUserData() async {
        // get current user
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }
        do {
            // get the user document where current user id matches
            let querySnapshot = try await db.collection("users").whereField("id", isEqualTo: user.uid).getDocuments()
            
            guard let document = querySnapshot.documents.first else {
                print("No documents found")
                return
            }
            
            // get the data for that user
            let userData = document.data()
            // make instance for it to use in currUser
            self.currUser = User(id: userData["id"] as! String, name: userData["name"] as! String, email: userData["email"] as! String, password: userData["password"] as! String, recommendationIds: userData["recommendationIds"] as! [String], bookmarkIds: userData["bookmarkIds"] as! [String]
            )
//            print(self.currUser!)
        } catch {
            print("Error querying Firestore: \(error.localizedDescription)")
        }
            
    }

    // gets the place recommendation the current user has from Firebase
    // use recommendationIds array of current user to search Firebase for matching places
    // gets the placeId from user and then finds it in place colletion to get place data
    func getPlaces() {
        guard let recId = currUser?.recommendationIds else {
            print("no recommendations for current user")
            return
        }
        
        // get all places where the place id matches one in user recommendationIds
        // (get all the places where user has recommended which is located in an array of recommendation ids)
        db.collection("places").whereField("id", in: recId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying Firestore: \(error.localizedDescription)")
                return
            }
            // Check if any documents match the query
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            // get place info
            for document in documents {
                let placeData = document.data()
                guard let id = placeData["id"] as? String,
                      let name = placeData["name"] as? String,
                      let city = placeData["city"] as? String,
                      let latitude = placeData["latitude"] as? Double,
                      let longitude = placeData["longitude"] as? Double else {
                    print("failed")
                    continue
                }
                
                // create instance to use in app
                let place = Place(id: id, name: name, city: city, latitude: latitude, longitude: longitude)
                
                DispatchQueue.main.async {
                    // add the place to profile page list
                    self.rex.append(place)
                }
            }
        }
    }
    
    // adds bookmark to want to visit list
    func addBookMark(_ place: Place) {
//        <<future>>: connect to firebase collection
        bookmarkList.append(place)
    }
    
    func removeBookMark(_ place: Place) {
//        <<future>>: connect to firebase collection
        if let removeIndex = bookmarkList.firstIndex(of: place) {
            bookmarkList.remove(at: removeIndex)
        }
    }
    
    // adds place to users rec list and updates to firebase
    // adds the new added place into firebase so that user recommendationIds is updated with new place cell
    // persistent data
    func addPlace(_ place: Place) {
//        <<future>>: don't add place if it already exist in place collection
        // add to user rec list
        rex.append(place)
        
        guard let userId = currUser?.id else {
            print("User ID is nil. Cannot update Firestore.")
            return
        }
        
        let userDocRef = db.collection("users").document(userId)
        print(userDocRef)
        
        // get the document of user from collection
        db.collection("users").whereField("id", isEqualTo: userId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying Firestore: \(error.localizedDescription)")
                return
            }
            // Check if any documents match the query
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            print(documents)
            print(userId)
            
            let document = documents[0]
            let documentReference = document.reference
            
            // get exiisting array of recIds or create new
            var recommendationIds = document.data()["recommendationIds"] as? [String] ?? []
            // if the user didn't already recommend the place, add it to its recommendations
            if !recommendationIds.contains(place.id) {
                // add and display it to profile page
                recommendationIds.append(place.id)
                
                // actually update firebase for persistent data
                documentReference.updateData(["recommendationIds": recommendationIds])
            }
        }
        
        // create one or update place to place collection
        let placesCollection = db.collection("places").document(place.id)
        
        placesCollection.setData([
            "id": place.id,
            "name": place.name,
            "city": place.city,
            "latitude": place.latitude,
            "longitude": place.longitude
        ]) { error in
            if let error = error {
                print("Error updating Firestore: \(error.localizedDescription)")
            } else {
                print("Place added to Firestore successfully.")
            }
        }
    }
    
    // removes place from List
    func removePlace(_ place: Place) {
//        <<future>>: connect to firebase collection (currently does not have persistent storage since it does not remove in Firebase)
        if let removeIndex = rex.firstIndex(of: place) {
            rex.remove(at: removeIndex)
        }
    }
    
// dummy data
    init() {
        // profile page
        bookmarkList = [
            Place(
                id: UUID().uuidString,
                name: "Catch LA",
                city: "West Hollywood, CA",
                latitude: 0.0,
                longitude: 0.0
            ),
            Place(
                id: UUID().uuidString,
                name: "The Getty",
                city: "Los Angeles, CA",
                latitude: 0.0,
                longitude: 0.0
            ),
        ]
        // feed page
        feedList = [
            Place(id: UUID().uuidString, name: "Verve Coffee Roasters", city: "Los Angeles, CA", latitude: 0.0, longitude: 0.0),
            Place(id: UUID().uuidString, name: "Rose Bowl Flea Market", city: "Pasadena, CA", latitude: 0.0, longitude: 0.0),
            Place(id: UUID().uuidString, name: "Maru Coffee", city: "Los Angeles, CA", latitude: 0.0, longitude: 0.0),
            Place(id: UUID().uuidString, name: "El Matador State Beach", city: "Malibu, CA", latitude: 0.0, longitude: 0.0),
            Place(id: UUID().uuidString, name: "University of Southern California", city: "Los Angeles, CA", latitude: 0.0, longitude: 0.0),
        ]
    }
}
