//
//  IndexViewModel.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


struct Song : Codable {
    let id: Int
    let name: String
    let file: String
    let image: String
    let artist: Artist
}

struct Artist: Codable {
    let id: Int
    let name: String
}

class IndexViewModel : ObservableObject {
    @Published var songs: [Song] = []
    
    func fetch() {
        guard let url = URL(string: "\(Env.apiUrl)/songs/") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                self.songs = try JSONDecoder().decode([Song].self, from: data)
            } catch {
                print(error)
            }
        }.resume()
    }
}



