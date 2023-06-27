//
//  Playlist.swift
//  ListenMusic
//
//  Created by Emanuel on 21/06/23.
//

import SwiftUI
import SwiftUITrackableScrollView


struct PlaylistSongCard: View {
    
    let song: Song
    
    var body: some View {
        NavigationLink(destination: MediaPlayerView()) {
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
        .foregroundColor(.primary)
    }
}

struct PlaylistView: View {
    
    let name: String
    let author: String
    
    @State var scroll: CGFloat = .zero
    
    @State var imageWidthHeight: CGFloat = 300
    
    @State var imageOpacity: Double = 1
    
    @State var gradientHeightBottom: CGFloat = 0.5
    @State var gradientHeightTop: CGFloat = 0
    
    @Environment(\.dismiss) var dismiss
    
    let screenWidth = Main.screen.width
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                LinearGradient(colors: [.purple, .black], startPoint: UnitPoint(x: 0.5, y: gradientHeightTop), endPoint: UnitPoint(x: 0.5, y: gradientHeightBottom)).edgesIgnoringSafeArea(.all)
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding(.horizontal)
                    .zIndex(1)
                    .onTapGesture {
                        dismiss.callAsFunction()
                    }
                
                ZStack(alignment: .top) {
                    
                    Rectangle()
                        .fill(.red)
                        .opacity(imageOpacity)
                        .frame(width: imageWidthHeight, height: imageWidthHeight)
                        .onChange(of: scroll) { newValue in
                            let scrollRate = scroll * 0.4
                            if scrollRate <= 80 {
                                let newImageWidthHeight = 300 - scrollRate
                                imageWidthHeight = newImageWidthHeight < Main.screen.width ? newImageWidthHeight : Main.screen.width
                                imageOpacity = 1 - Double(scrollRate) * 1.25 / 100
                                gradientHeightBottom = (1 - scroll / screenWidth) / 2
                                gradientHeightTop = -scrollRate / screenWidth / 2
                            }
                        }
                    
                    TrackableScrollView(contentOffset: $scroll) {
                        VStack(alignment: .leading) {
                            Spacer()
                                .frame(height: 310)
                            Text(name)
                                .font(.title)
                                .bold()
                            HStack {
                                Circle()
                                    .frame(width: 25)
                                    .foregroundColor(.green)
                                    .overlay {
                                        Text(author.prefix(1).uppercased())
                                            .foregroundColor(.black)
                                    }
                                Text(author)
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
                        .padding(.horizontal)
                    }
                    .clipped()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PlaylistView(name: "Playlist", author: "Manel")
                .preferredColorScheme(.dark)
        }
    }
}
