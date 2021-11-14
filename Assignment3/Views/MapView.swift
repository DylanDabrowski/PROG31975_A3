//
//  MapView.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import SwiftUI
import MapKit

struct Location : Identifiable {
    let id = UUID()
    let name : String
    let coordinate : CLLocationCoordinate2D
}

struct RouteSteps : Identifiable {
    let id = UUID()
    let step : String
}

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State var firstStop : String = ""
    @State var secondStop : String = ""
    @State var finalDestination : String = ""
    
    @State var routeSteps : [RouteSteps] = [RouteSteps(step: "Enter a destination")]
    @State var annotations : [Location] = []
    
    var body: some View {
        
        VStack {
            VStack {
                TextField("First Stop", text: $firstStop)
                    .padding(5)
                TextField("Second Stop", text: $secondStop)
                    .padding(5)
                TextField("Final Destination", text: $finalDestination)
                    .padding(5)
                Button(action: {
                    locate(loc: firstStop)
                    locate(loc: secondStop)
                    locate(loc: finalDestination)
                }, label: {
                    Text("Locate")
                }).padding(5)
                Button(action: {
                    route()
                }, label: {
                    Text("Route")
                }).padding(5)
            }.padding(5)
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .padding(10)
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            
            List(routeSteps) { r in
                Text(r.step)
            }
            
        }
        
    }
    
    func locate(loc : String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(loc, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil) {
                print("Error at geocode")
            }
            
            if let placemark = placemarks?.first {
                let coordinates : CLLocationCoordinate2D = placemark.location!.coordinate
                annotations.append(Location(name: placemark.name!, coordinate: coordinates))
                
            }
        })
        
        
        
    }
    
    func route() {
        
        let request1 = MKDirections.Request()
        request1.source = MKMapItem(placemark: MKPlacemark(coordinate: viewModel.userLocation, addressDictionary: nil))
        request1.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotations[0].coordinate, addressDictionary: nil))
        request1.requestsAlternateRoutes = false
        request1.transportType = .automobile
        
        let directions1 = MKDirections(request: request1)
        directions1.calculate(completionHandler: {response, error in
        
            for route in (response?.routes)! {
                self.routeSteps = []
            
                for step in route.steps {
                    self.routeSteps.append(RouteSteps(step: step.instructions))
                }
            
            }
        
        })
        
        let request2 = MKDirections.Request()
        request2.source = MKMapItem(placemark: MKPlacemark(coordinate: annotations[0].coordinate, addressDictionary: nil))
        request2.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotations[1].coordinate, addressDictionary: nil))
        request2.requestsAlternateRoutes = false
        request2.transportType = .automobile
        
        let directions2 = MKDirections(request: request2)
        directions2.calculate(completionHandler: {response, error in
        
            for route in (response?.routes)! {
                self.routeSteps = []
            
                for step in route.steps {
                    self.routeSteps.append(RouteSteps(step: step.instructions))
                }
            
            }
        
        })
        
        let request3 = MKDirections.Request()
        request3.source = MKMapItem(placemark: MKPlacemark(coordinate: annotations[1].coordinate, addressDictionary: nil))
        request3.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotations[2].coordinate, addressDictionary: nil))
        request3.requestsAlternateRoutes = false
        request3.transportType = .automobile
        
        let directions3 = MKDirections(request: request1)
        directions3.calculate(completionHandler: {response, error in
        
            for route in (response?.routes)! {
                self.routeSteps = []
            
                for step in route.steps {
                    self.routeSteps.append(RouteSteps(step: step.instructions))
                }
            
            }
        
        })
        
        
    }
    
}
