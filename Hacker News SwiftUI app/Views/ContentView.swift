//
//  ContentView.swift
//  Hacker News SwiftUI app
//
//  Created by Oleksandr Smakhtin on 28.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    // ObservedObject is a listener
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
                
            }
            .navigationTitle("Hacker News")
            
        }
        // method kinda ViewDidLoad()
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



