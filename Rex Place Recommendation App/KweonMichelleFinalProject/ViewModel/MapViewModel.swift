//
//  MapViewModel.swift
//  KweonMichelleFinalProject
//
//  Created by Michelle Kweon on 11/22/23.
//

import Foundation
import CoreLocation
import MapKit

// has logic for MapKit and getting users location 
class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = MapViewModel()

    @Published var lastLocation: CLLocation?
    let manager = CLLocationManager()
    
    override init() {
        super.init()

        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10.0

        manager.delegate = self // receives events and processes it accordingly
    }

    // request users location and get location
    func request(){
        manager.requestAlwaysAuthorization()
//        manager.requestLocation()
        manager.startUpdatingLocation()
    }

    // handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    // This method will be called by the location manager whenever the user's location has surpass the distanceFilter -- update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
//        DispatchQueue.main.async {
//            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        }
        
        lastLocation = location
        // manager.stopUpdatingLocation()

        print("lat: \(location.coordinate.latitude) lng: \(location.coordinate.longitude)")
    }
}
