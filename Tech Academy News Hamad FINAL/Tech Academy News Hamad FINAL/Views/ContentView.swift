//
//  ContentView.swift
//  Tech Academy News Hamad FINAL
//
//  Created by DVP on 20/03/2024.
//

import SwiftUI

struct ContentView: View{
    @StateObject var data = SpaceAPI()
    @State private var opac = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                NewsView()
                    .opacity(opac)
            }
            .navigationTitle("Super Earth News")
            .environmentObject(data)
            .onAppear {
                data.getData()
                
                withAnimation(.easeIn(duration: 2)) {
                    opac = 1.0
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
