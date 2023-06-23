//
//  MediaPlayerView.swift
//  ListenMusic
//
//  Created by Emanuel on 22/06/23.
//

import SwiftUI

struct MediaPlayerView: View {
    @State var slider = 0.0
    
    static let songs = [
        Song(id: 0, name: "Música 1", file: "", image: "", artist: Artist(id: 0, name: "manel")),
        Song(id: 0, name: "Música 2", file: "", image: "", artist: Artist(id: 0, name: "cantor")),
        Song(id: 0, name: "Música 3", file: "", image: "", artist: Artist(id: 0, name: "artista"))
    ]
    
    @State var selection: Song = songs[0]
    
    @State var position: CGSize = .zero
    
    @State var lastPosition = CGFloat.zero
    
    @State var currentTime = 0.0
    
    @State var duration = 100.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var step = (Main.screen.width - 57.5) / 100
    
    @State var isSliding = false
    
    func getFormatedTime(time: CGFloat) -> String {
        let minutes = floor(time / 60)
        let seconds = time - minutes * 60
        return String(format: "%2.0f:%02.0f", minutes, seconds)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.red.ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "chevron.down")
                    Spacer()
                    Text("Playlist")
                        .font(.system(size: 17))
                        .bold()
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.vertical, 10)
                .font(.title2)
                
                TabView(selection: $selection){
                    ForEach(MediaPlayerView.songs, id: \.self) { song in
                        Rectangle()
                            .fill(.blue)
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 25)
                            .tag(song)
                    }
                }
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, -25)
                
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text(selection.name)
                        .font(.title)
                        .bold()
                    Text(selection.artist.name)
                        .font(.title3)
                }
                
                HStack {
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 5)
                            Rectangle()
                                .frame(width: position.width > 0 ? position.width : 0, height: 5)
                            Circle()
                                .fill(.white)
                                .frame(width: 15)
                                .offset(position)
                                .onChange(of: currentTime) { _ in
                                    if !isSliding {
                                        position.width = step * currentTime
                                        lastPosition = position.width
                                    }
                                }
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged({ value in
                                            isSliding = true
                                            if lastPosition + value.translation.width > -7.5 && lastPosition + value.translation.width < Main.screen.width - 57.5{
                                                position = CGSize(width: lastPosition + value.translation.width, height: 0)
                                            }
                                        })
                                        .onEnded({ value in
                                            isSliding = false
                                            lastPosition = position.width
                                            currentTime = position.width / step
                                        })
                                )
                        }
                        HStack {
                            Text(getFormatedTime(time: currentTime))
                            Spacer()
                            Text(getFormatedTime(time: duration))
                        }
                        .font(.system(size: 14))
                        .onReceive(timer) { _ in
                            if currentTime < duration {
                                currentTime += 0.1
                            }
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "shuffle")
                        .font(.title)
                    Spacer()
                    Image(systemName: "backward.end.fill")
                        .font(.system(size: 40))
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 70))
                    Spacer()
                    Image(systemName: "forward.end.fill")
                        .font(.system(size: 40))
                    Spacer()
                    Image(systemName: "repeat")
                        .font(.title)
                }
                
                Spacer()
                                
                HStack {
                    Image(systemName: "hifispeaker")
                        .foregroundColor(.green)
                    Text("Dispositivo de música")
                        .foregroundColor(.green)
                }
                .font(.system(size: 16))
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 25)
        }
    }
}

struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView()
            .preferredColorScheme(.dark)
    }
}
