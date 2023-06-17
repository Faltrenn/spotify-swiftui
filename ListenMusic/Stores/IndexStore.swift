//
//  IndexStore.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

class AudioManager: ObservableObject {
    @Published var player = AVPlayer()
    
    @Published var isPlaying: Bool = false
    
    @Published var song: Song? = nil
    
    func play(song: Song? = nil) {
        if let song = song {
            guard let url = URL(string: song.file) else {
                return
            }
            player = AVPlayer(url: url)
            self.song = song
        }
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func isPlay() -> Bool {
        player.isPlaying
    }
}
