//
//  SongFormViewModel.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI

class SongFormViewModel: ObservableObject {
    @Published var input: String = ""
    @Published var selection: Int = 0
    
    @Published var artists: [Artist] = []
    
    func fetch() {
        guard let url = URL(string: "\(Env.apiUrl)/artists/") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                self.artists = try JSONDecoder().decode([Artist].self, from: data)
            } catch {
                print(error)
            }
        }.resume()
    }
}
