//
//  ArtistFormViewModel.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


class ArtistFormViewModel: ObservableObject {
    @State var input: String = ""
    
    func send() {
        guard let url = URL(string: "\(Env.apiUrl)/artists/") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["name" : input])
        } catch {
            print(error)
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
        }.resume()
    }
}
