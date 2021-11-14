//
//  ContentView.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import SwiftUI

// NOTE: When running wait a few seconds after pressing "Locate" before pressing "Route" as I have not implemented async yet.

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Map Navigation Using SwiftUI")
                    .padding(50)
                NavigationLink(destination: MapView()) {
                    Text("Begin")
                }.padding(50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
