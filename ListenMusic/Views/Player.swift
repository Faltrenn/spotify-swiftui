//
//  Player.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import SwiftUI


struct PlayerView: View {
    @State var slider: Float = 0.0
    
    @State var playing: Bool = false
    @State var shuffle: Bool = false
    @State var repeatMode: Int = 0
    
    var body: some View {
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
                    Text("...")
                        .font(.title)
                        .bold()
                }
                Spacer()
                Rectangle()
                    .fill(.black)
                    .aspectRatio(1, contentMode: .fit)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Nome da música")
                        .font(.title)
                        .bold()
                    Text("Nome do cantor")
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
                    Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                        .onTapGesture {
                            playing.toggle()
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
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .preferredColorScheme(.dark)
    }
}


