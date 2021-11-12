//
//  ContentView.swift
//  Assignment3
//
//  Created by Dylan Dabrowski on 2021-11-12.
//

import SwiftUI

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