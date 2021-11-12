//
//  MapView.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var firstStop : String = ""
    @State var secondStop : String = ""
    @State var finalDestination : String = ""
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
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
                    
                }, label: {
                    Text("Go!")
                }).padding(10)
            }.padding(10)
            
            Map(coordinateRegion: $region)
                .padding(10)
            
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
