//
//  SongForm.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


struct SongForm: View {
    @StateObject var viewModel: SongFormViewModel = SongFormViewModel()
    var body: some View {
        VStack {
            List {
                TextField("Nome da música", text: $viewModel.input)
                Picker("Artistas", selection: $viewModel.selection) {
                    ForEach(viewModel.artists, id: \.id) { artist in
                        Text(artist.name)
                            .tag(artist.id)
                    }
                }
                Button("Enviar") { }
            }
        }
        .tabItem {
            Image(systemName: "heart")
            Text("SongForm")
        }
        .tag(2)
        .onAppear {
            viewModel.fetch()
        }
    }
}
