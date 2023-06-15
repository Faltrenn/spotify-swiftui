//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct Env {
    static let ips = ["http://192.168.0.101:8000","http://127.0.0.1:8000","http://172.20.10.11:8000"]
    static let apiUrl = ips[1]
}

class MediaPlayerViewModel : ObservableObject {
    @Published var song: Song?
    
    @Published var translation = CGSize(width: 0, height: UIScreen.main.bounds.size.height - 150)
    @Published var fixedPosition = CGSize(width: 0, height: UIScreen.main.bounds.size.height - 150)
        
    func setMusic(song: Song) {
        self.song = song
    }
}

struct MediaPlayer : View {
    @StateObject var viewModel = MediaPlayerViewModel()
    
    @EnvironmentObject var audioManager : AudioManager
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .top) {
            PlayerView(song: viewModel.song)
            
            HStack {
                if let song = viewModel.song {
                    AsyncImage(url: URL(string: song.image)) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
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
                                if audioManager.isPlaying {
                                    audioManager.pause()
                                } else {
                                    audioManager.play()
                                }
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

struct ContentView: View {
    @State var page: Int = 0
    
    var body: some View {
        Index()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(AudioManager())
    }
}
