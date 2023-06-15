//
//  Player.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


struct PlayerView: View {
    @State var slider: Float = 0.0
    
    @State var shuffle: Bool = false
    @State var repeatMode: Int = 0
    
    @EnvironmentObject var audioManager: AudioManager
    
    let song: Song?
    
    var body: some View {
        if let song = song {
            ZStack {
                Color.red.ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "chevron.down")
                            .font(.title)
                        Spacer()
                        Text("Nome Playlist")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Image(systemName: "ellipsis")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    AsyncImage(url: URL(string: song.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                    }placeholder: {
                        Rectangle()
                            .fill(.gray)
                            .aspectRatio(1.0, contentMode: .fit)
                            .overlay {
                                ProgressView()
                            }
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(song.name)
                            .font(.title)
                            .bold()
                        Text(song.artist.name)
                            .font(.title3)
                    }
                    .padding(.bottom)
                    
                    Slider(value: $slider)
                    
                    HStack {
                        Image(systemName: "shuffle")
                            .font(.system(size: 30))
                            .foregroundColor(shuffle ? .green : .primary)
                            .onTapGesture {
                                shuffle.toggle()
                            }
                            .overlay {
                                if shuffle {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6))
                                        .foregroundColor(.green)
                                        .offset(CGSize(width: -3, height: 20))
                                }
                            }
                        Spacer()
                        Image(systemName: "backward.end.fill")
                            .font(.system(size: 40))
                        Spacer()
                        Image(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 70))
                            .onTapGesture {
                                if audioManager.isPlaying {
                                    audioManager.player.pause()
                                } else {
                                    audioManager.player.play()
                                }
                            }
                        Spacer()
                        Image(systemName: "forward.end.fill")
                            .font(.system(size: 40))
                        Spacer()
                        Image(systemName: repeatMode == 2 ? "repeat.1" : "repeat")
                            .font(.system(size: 30))
                            .foregroundColor(repeatMode > 0 ? .green : .primary)
                            .overlay {
                                if repeatMode == 1 {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6))
                                        .foregroundColor(.green)
                                        .offset(CGSize(width: 0, height: 20))
                                }
                            }
                            .onTapGesture {
                                repeatMode = repeatMode == 2 ? 0 : repeatMode + 1
                            }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 40) {
                        Image(systemName: "tv.and.hifispeaker.fill")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                        Image(systemName: "list.bullet")
                    }
                    .font(.title)
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                audioManager.play(url: song.file)
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(song: Song(id: 0, name: "Musica", file: "", image: "", artist: Artist(id: 0, name: "Musico")))
            .preferredColorScheme(.dark)
    }
}


