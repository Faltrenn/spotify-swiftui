//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI
import AVFoundation

struct Env {
    static let apiUrl = "http://172.20.10.11:8000"
}

class AudioManager: ObservableObject {
    @Published var player = AVPlayer()
    
    func play(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        player = AVPlayer(url: url)
        player.play()
    }
}


struct SongCard: View {
    @State var click: Bool = false
    
    let song: Song
    
    var audioManager = AudioManager()
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: song.image)) { image in
                image
                    .resizable()
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .overlay {
                        ProgressView()
                    }
            }
            .cornerRadius(5)
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .font(.title2)
                Text(song.artist.name)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: click ? "heart.fill" : "heart")
                .font(.title)
                .foregroundColor(.red)
                .onTapGesture {
                    click.toggle()
                }
        }
        .padding(.horizontal)
        .onTapGesture {
            audioManager.play(url: song.file)
        }
    }
}

struct Index : View {
    @StateObject var viewModel: IndexViewModel = IndexViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.songs, id: \.id) { song in
                    SongCard(song: song)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetch()
        }
        .tag(0)
        .tabItem {
            Image(systemName: "heart")
            Text("Index")
        }
    }
}

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
