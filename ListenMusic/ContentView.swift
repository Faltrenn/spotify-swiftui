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
    
    let color: Color = .white.opacity(0.15)
    
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
            .background(color)
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
                .frame(width: UIScreen.main.bounds.width * 0.56)
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
    
    let color: Color = .white.opacity(0.15)
    
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
                            .background(color)
                            .cornerRadius(30)
                        Text("Podcasts e programas")
                            .font(.system(size: 14))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(color)
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
                .padding(.bottom, 95)
            }
            .ignoresSafeArea(edges: .bottom)
            .clipped()
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

enum TabbedPages: Int, CaseIterable {
    case home = 0
    case search
    case library
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return "Your library"
        }
        
    }
    
    var unselectedIcon: String {
        switch self {
        case .home:
            return "home"
        case .search:
            return "search"
        case .library:
            return "library"
        }
    }
    var selectedIcon: String {
        switch self {
        case .home:
            return "home.fill"
        case .search:
            return "search.fill"
        case .library:
            return "library.fill"
        }
    }
}

struct Library: View {
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Circle()
                    .frame(width: 40)
                    .foregroundColor(.green)
                    .overlay {
                        Text("E")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                Text("Your library")
                    .font(.system(size: 30))
                    .bold()
                Spacer()
                Image("search")
                    .renderingMode(.template)
                    .padding(.trailing, 15)
                Image(systemName: "plus")
                    .font(.title)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Text("X")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.15))
                        .cornerRadius(30)
                        
                    ForEach(0...9, id:\.self) { _ in
                        Text("Playlists")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 5)
                            .background(.white.opacity(0.15))
                            .cornerRadius(20)
                    }
                }
            }
            
            ScrollView {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 14))
                        .bold()
                    Text("Recents")
                        .bold()
                        .font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 18))
                }
                VStack {
                    HStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 60, height: 60)
                            .cornerRadius(5)
                            .overlay {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Liked Songs")
                                .bold()
                                .font(.title3)
                            HStack(spacing: 5) {
                                Image("pin")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                Text("Playlist 240 songs")
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Rectangle()
                            .fill(.green.opacity(0.5))
                            .frame(width: 60, height: 60)
                            .cornerRadius(5)
                            .overlay {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("New Episodes")
                                .bold()
                                .font(.title3)
                            HStack(spacing: 5) {
                                Image("pin")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                Text("Updates Mar 31, 2023")
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Rectangle()
                            .fill(.green.opacity(0.5))
                            .frame(width: 60, height: 60)
                            .cornerRadius(5)
                            .overlay {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Your Episodes")
                                .bold()
                                .font(.title3)
                            HStack(spacing: 5) {
                                Image("pin")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                Text("Autor da playlist")
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    
                    ForEach(0...9, id: \.self) { _ in
                        HStack {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 60, height: 60)
                                .cornerRadius(5)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Your Episodes")
                                    .bold()
                                    .font(.title3)
                            Text("Autor da playlist")
                                .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 95)
            }
        }
    }
}

struct ContentView: View {
    @State var selectedPage: TabbedPages = .home
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                switch selectedPage {
                case .home:
                    Container()
                case .search:
                    Search()
                case .library:
                    Library()
                }
            }
            .padding(.horizontal, 15)
            .ignoresSafeArea(edges: .bottom)
            HStack(alignment: .top) {
                ForEach(TabbedPages.allCases, id: \.self) { page in
                    VStack {
                        Image(page == selectedPage ? page.selectedIcon : page.unselectedIcon)
                            .renderingMode(.template)
                        Text(page.title)
                            .font(.system(size: 10))

                    }
                    .foregroundColor(selectedPage == page ? .white : .gray)
                    .onTapGesture {
                        selectedPage = page
                    }
                    if page != TabbedPages.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 50)
            .frame(height: 95, alignment: .top)
            .background(LinearGradient(colors: [.black.opacity(0.85), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(AudioManager())
    }
}
