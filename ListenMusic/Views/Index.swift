//
//  Index.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


struct Index : View {
    @StateObject var viewModel: IndexViewModel = IndexViewModel()
    
    @StateObject var mediaPlayerViewModel = MediaPlayerViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.songs) { song in
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
            
            MediaPlayer(viewModel: mediaPlayerViewModel)
        }
    }
}
