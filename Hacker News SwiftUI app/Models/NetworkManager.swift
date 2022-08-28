//
//  NetworkManager.swift
//  Hacker News SwiftUI app
//
//  Created by Oleksandr Smakhtin on 28.08.2022.
//

import Foundation


class NetworkManager: ObservableObject {
    
    // Published - means whenever this object changes tell the listener
    @Published var posts = [Post]()
    
    func fetchData() {
        
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("-----------URLSession error: \(error.localizedDescription)------------")
                }
                
                if let safeData = data {
                    if let results = self.parseJSON(data: safeData) {
                        DispatchQueue.main.async {
                            self.posts = results.hits
                        }
                    }
                    print("-----------Successfully parsed JSON------------")
                    
                }
                
                
                
            }
            task.resume()
        }
        
    }
    
    
    
    func parseJSON(data: Data) -> Results? {
        
        let decoder = JSONDecoder()
        do {
            let results = try decoder.decode(Results.self, from: data)
            return results
        } catch {
            print("-----------JSON error\(error.localizedDescription)-----------")
            return nil
        }
        
    }
    
}





