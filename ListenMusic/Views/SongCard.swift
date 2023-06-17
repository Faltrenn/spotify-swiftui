//
//  SongCard.swift
//  ListenMusic
//
//  Created by Emanuel on 16/06/23.
//

import SwiftUI


struct SongCard: View {
    @State var click: Bool = false
    
    let song: Song
    
    @EnvironmentObject var audioManager: AudioManager
    
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
            audioManager.play(song: song)
        }
    }
}
