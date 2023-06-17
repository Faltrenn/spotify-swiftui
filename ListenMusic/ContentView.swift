//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct Env {
    static let ips = [
        "http://192.168.0.101:8000",
        "http://127.0.0.1:8000",
        "http://172.20.10.11:8000",
        "http://192.168.0.106:8000"
    ]
    
    static let apiUrl = ips[3]
}

struct ContentView: View {
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
