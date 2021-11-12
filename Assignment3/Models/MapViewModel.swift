//
//  MapViewModel.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import MapKit
enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager : CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show alert letting user know this is off and to turn it on")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
    
        switch locationManager.authorizationStatus {
                    
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your Location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this permission, go into setting to fix this.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
