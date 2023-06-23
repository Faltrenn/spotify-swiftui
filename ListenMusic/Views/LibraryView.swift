//
//  Library.swift
//  ListenMusic
//
//  Created by Emanuel on 21/06/23.
//

import SwiftUI


struct LibraryView: View {
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
        .padding(.horizontal)
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedPage: .library)
    }
}
