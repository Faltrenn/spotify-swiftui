//
//  ListenMusicApp.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

@main
struct ListenMusicApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(selectedPage: .home)
                .environmentObject(audioManager)
        }
    }
}
