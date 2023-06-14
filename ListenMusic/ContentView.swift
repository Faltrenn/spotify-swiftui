//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct Env {
    static let apiUrl = "http://172.20.10.11:8000"
}

struct ContentView: View {
    @State var page: Int = 2
    var body: some View {
        TabView(selection: $page) {
            Index()
            ArtistForm()
            SongForm()
        }
    }
}












































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
