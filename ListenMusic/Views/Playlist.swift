//
//  Playlist.swift
//  ListenMusic
//
//  Created by Emanuel on 21/06/23.
//

import SwiftUI


struct PlaylistSongCard: View {
    
    let song: Song
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: song.name)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: 60)
            VStack(alignment: .leading, spacing: 2) {
                Text(song.name)
                    .font(.title3)
                HStack(spacing: 5) {
                    Circle()
                        .frame(width: 15)
                        .foregroundColor(.green)
                        .overlay{
                            Image(systemName: "arrow.down")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 10))
                        }
                    Text("E")
                        .padding(.horizontal, 5)
                        .background(.gray)
                        .cornerRadius(4)
                    Text(song.artist.name)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct Playlist: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(systemName: "chevron.left")
                .font(.title3)
            Rectangle()
                .fill(.red)
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 50)
            ScrollView {
                Spacer()
                    .frame(height: 320)
                VStack(alignment: .leading) {
                    Text("Playlist")
                        .font(.title)
                        .bold()
                    HStack {
                        Circle()
                            .frame(width: 25)
                            .foregroundColor(.green)
                            .overlay {
                                Text("A")
                                    .foregroundColor(.black)
                            }
                        Text("Autor")
                            .bold()
                    }
                    HStack {
                        Image(systemName: "globe")
                        Text("22 min")
                    }
                    .foregroundColor(.gray)
                    HStack(spacing: 25) {
                        Circle()
                            .frame(width: 30)
                            .foregroundColor(.green)
                            .overlay{
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.title3)
                            }
                        Image(systemName: "person")
                            .overlay(alignment: .topLeading) {
                                Image(systemName: "plus")
                                    .bold()
                                    .font(.system(size: 12))
                                    .offset(CGSize(width: -3, height: -3))
                            }
                            .font(.title)
                        Image(systemName: "ellipsis")
                            .font(.title2)
                        
                        Spacer()
                        
                        Image(systemName: "shuffle")
                            .font(.title)
                        
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 55))
                            .foregroundColor(.green)
                    }
                    .foregroundColor(.gray)
                    HStack {
                        Rectangle()
                            .aspectRatio(1.0,contentMode: .fit)
                            .frame(height: 60)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 35))
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Adicionar a esta playlist")
                                .font(.title3)
                        }
                    }
                    
                    ForEach(0...10, id: \.self) { c in
                        PlaylistSongCard(song: Song(id: 0, name: "Música \(c)", file: "", image: "", artist: Artist(id: 0, name: "Cantor \(c)")))
                    }
                }
            }
        }
    }
}
struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedPage: .home)
    }
}
