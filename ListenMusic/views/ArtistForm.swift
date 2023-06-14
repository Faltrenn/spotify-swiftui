//
//  ArtistForm.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI

struct ArtistForm: View {
    @StateObject var viewModel: ArtistFormViewModel = ArtistFormViewModel()
    var body: some View {
        VStack {
            TextField("Opa", text: $viewModel.input)
            Button("Enviar") {
                viewModel.send()
            }
        }
        .tag(1)
        .tabItem {
            Image(systemName: "heart")
            Text("ArtistForm")
        }
    }
}
