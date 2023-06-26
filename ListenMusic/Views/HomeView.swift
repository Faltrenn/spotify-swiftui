//
//  Home.swift
//  ListenMusic
//
//  Created by Emanuel on 21/06/23.
//

import SwiftUI


struct HomeHead: View {
    var body: some View {
        HStack(spacing: 20) {
            Text("Bom dia")
                .bold()
                .font(.system(size: 25))
            Spacer()
            Image(systemName: "bell")
            Image(systemName: "clock")
            Image(systemName: "gearshape")
        }
        .font(.system(size: 23))
        .padding(.top, 40)
    }
}

struct PlaylistCard : View {
    let name: String
    let author: String
    let type: Bool
        
    var body: some View {
        NavigationLink(destination: PlaylistView(name: name, author: author)) {
            HStack {
                if type {
                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                        GridRow {
                            Rectangle()
                                .fill(.red)
                                .aspectRatio(contentMode: .fit)
                            Rectangle()
                                .fill(.blue)
                                .aspectRatio(contentMode: .fit)
                        }
                        GridRow {
                            Rectangle()
                                .fill(.green)
                                .aspectRatio(contentMode: .fit)
                            Rectangle()
                                .fill(.yellow)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(minWidth: 50)
                } else {
                    Rectangle()
                        .fill(.red)
                        .aspectRatio(1.0, contentMode: .fit)
                }
                Text(name)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                Spacer()
            }
            .background(CustomColors.cards)
            .frame(height: 50)
            .cornerRadius(5)
            .bold()
            .foregroundColor(.primary)
        }
    }
}

struct NewMusic: View {
    let song: Song
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Circle()
                    .frame(width: 50)
                VStack(alignment: .leading) {
                    Text("Novo lançamento de")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text(song.artist.name)
                        .font(.system(size: 24))
                        .bold()
                }
                Spacer()
            }
            
            HStack(spacing: 0) {
                Rectangle()
                    .scaledToFit()
                VStack(alignment: .leading, spacing: 0) {
                    Text(song.name)
                        .font(.system(size: 15))
                        .bold()
                    Text(song.artist.name)
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                            .font(.title)
                            .bold()
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 35))
                    }
                    .padding(.top, 5)
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width * 0.56)
            }
            .background(CustomColors.cards)
            .cornerRadius(5)
        }
    }
}

struct MixCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Título do Mix")
                .font(.title)
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach (0...4, id:\.self) { _ in
                        VStack(spacing: 10) {
                            Rectangle()
                                .fill(.orange)
                                .aspectRatio(contentMode: .fit)
                            Text("Artistas, do, mix, que, podem, ser, muitos, mesmo")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .lineLimit(2)
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, 15)
            }
            .padding(.horizontal, -15)
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    HomeHead()
                    
                    HStack(spacing: 10) {
                        Text("Músicas")
                            .font(.system(size: 14))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(CustomColors.cards)
                            .cornerRadius(30)
                        Text("Podcasts e programas")
                            .font(.system(size: 14))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(CustomColors.cards)
                            .cornerRadius(30)
                        Spacer()
                    }
                    
                    Grid(horizontalSpacing: 7, verticalSpacing: 7) {
                        GridRow {
                            PlaylistCard(name: "PH", author: "manel", type: true)
                            PlaylistCard(name: "FK", author: "manel", type: true)
                        }
                        GridRow {
                            PlaylistCard(name: "DJ FELIPE ALVES", author: "Spotfy", type: false)
                            PlaylistCard(name: "Brazilian Phonk Mano", author: "Spotify", type: false)
                        }
                        GridRow {
                            PlaylistCard(name: "Tarcísio do Acordeon", author: "Spotify", type: false)
                            PlaylistCard(name: "Playlist com muitos caracteres", author: "Spotify", type: false)
                        }
                    }
                    
                    NewMusic(song: Song(id: 0, name: "MIRAGE feat(KayBlack, Ozuna, Sfera Ebbast & GIMS)", file: "", image: "", artist: Artist(id: 0, name: "KayBlack")))
                    
                    ForEach(0...4, id: \.self) { _ in
                        MixCard()
                    }
                    
                }
                .padding(.bottom, 95)
                .padding(.horizontal)
            }
            .ignoresSafeArea(edges: .bottom)
            .clipped()
            .background(CustomColors.primary)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(.red)
    }
}
