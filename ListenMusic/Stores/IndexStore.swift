//
//  IndexStore.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import AVFoundation

class AudioManager: ObservableObject {
    @Published var player = AVPlayer()
    
    func play(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        player = AVPlayer(url: url)
        player.play()
    }
}
