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
    
    func play(url: String? = nil) {
        if let url = url {
            guard let url = URL(string: url) else {
                return
            }
            player = AVPlayer(url: url)
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
