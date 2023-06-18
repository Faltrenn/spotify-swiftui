//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct Env {
    static let ips = [
        "http://192.168.0.101:8000",
        "http://127.0.0.1:8000",
        "http://172.20.10.11:8000",
        "http://192.168.0.106:8000"
    ]
    
    static let apiUrl = ips[1]
}

struct PlaylistCard : View {
    let nome: String
    let type: Bool
    
    var body: some View {
        NavigationLink(destination: Text(nome)) {
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
                Text(nome)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .background(.gray)
            .frame(height: 50)
            .cornerRadius(5)
            .bold()
            .foregroundColor(.primary)
        }
    }
}

struct Head : View {
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
                .frame(width: UIScreen.main.bounds.width * 0.55)
            }
            .background(.gray)
            .cornerRadius(5)
        }
    }
}

struct Mixes: View {
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

struct Container: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    Head()
                    
                    HStack(spacing: 10) {
                        Text("Músicas")
                            .font(.system(size: 14))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.gray)
                            .cornerRadius(30)
                        Text("Podcasts e programas")
                            .font(.system(size: 14))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(.gray)
                            .cornerRadius(30)
                        Spacer()
                    }
                    
                    Grid(horizontalSpacing: 7, verticalSpacing: 7) {
                        GridRow {
                            PlaylistCard(nome: "PH", type: true)
                            PlaylistCard(nome: "FK", type: true)
                        }
                        GridRow {
                            PlaylistCard(nome: "DJ DELIPE ALVES", type: false)
                            PlaylistCard(nome: "Brazilian Phonk Mano", type: false)
                        }
                        GridRow {
                            PlaylistCard(nome: "Tarcísio do Acordeon", type: false)
                            PlaylistCard(nome: "Playlist com muitos caracteres", type: false)
                        }
                    }
                    
                    NewMusic(song: Song(id: 0, name: "MIRAGE feat(KayBlack, Ozuna, Sfera Ebbast & GIMS)", file: "", image: "", artist: Artist(id: 0, name: "KayBlack")))
                    
                    ForEach(0...4, id: \.self) { _ in
                        Mixes()
                    }
                    
                }
                .padding(.horizontal, 15)
            }
        }
    }
}


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
        .padding(.horizontal)
    }
}


struct ContentView: View {
    var body: some View {
        Playlist()
        //Container()
        //Index()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(AudioManager())
    }
}
