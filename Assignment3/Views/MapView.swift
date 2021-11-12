//
//  MapView.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State var firstStop : String = ""
    @State var secondStop : String = ""
    @State var finalDestination : String = ""
    
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
                }).padding(5)
            }.padding(5)
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .padding(10)
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
