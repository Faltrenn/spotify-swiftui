//
//  MediaPlayer.swift
//  ListenMusic
//
//  Created by Emanuel on 16/06/23.
//

import SwiftUI


class MediaPlayerViewModel : ObservableObject {
    @Published var translation = CGSize(width: 0, height: UIScreen.main.bounds.size.height - 150)
    @Published var fixedPosition = CGSize(width: 0, height: UIScreen.main.bounds.size.height - 150)
}

struct MediaPlayer : View {
    @StateObject var viewModel = MediaPlayerViewModel()
    
    @EnvironmentObject var audioManager : AudioManager
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .top) {
            PlayerView(song: audioManager.song)
            
            HStack {
                if let song = audioManager.song {
                    AsyncImage(url: URL(string: song.image)) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(5)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text(song.name)
                        Text(song.artist.name)
                            .foregroundColor(.gray)
                    }
                    .font(.title3)
                    Spacer()
                    HStack {
                        Image(systemName: "tv.and.hifispeaker.fill")
                            .padding(.horizontal, 10)
                        Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                audioManager.playPause()
                            }
                    }
                    .font(.title)
                }
            }
            .padding(10)
            .background(.orange)
            .cornerRadius(5)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        viewModel.translation = CGSize(width: 0, height: viewModel.fixedPosition.height + value.translation.height)
                    }
                    .onEnded{ value in
                        if viewModel.fixedPosition.height - viewModel.translation.height <= -50 {
                            viewModel.translation = CGSize(width: 0, height: UIScreen.main.bounds.size.height - 150)
                            viewModel.fixedPosition = viewModel.translation
                            
                        } else if viewModel.fixedPosition.height - viewModel.translation.height >= 50 {
                            viewModel.translation = CGSize.zero
                            viewModel.fixedPosition = viewModel.translation
                        } else {
                            viewModel.translation = viewModel.fixedPosition
                        }
                    }
            )
        }
        .offset(CGSize(width: 0, height: viewModel.translation.height))
        .onReceive(timer) { _ in
            audioManager.isPlaying = audioManager.isPlay()
        }
    }
}
