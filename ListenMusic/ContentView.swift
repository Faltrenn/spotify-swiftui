//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct SongCard: View {
    @State var click: Bool = false
    var body: some View {
        HStack {
            Rectangle()
                .fill(.red)
                .frame(width: 70, height: 70)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text("Nome da música!")
                    .font(.title2)
                Text("Nome do cantor!")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: click ? "heart.fill" : "heart")
                .font(.title)
                .foregroundColor(.red)
                .onTapGesture {
                    click.toggle()
                }
        }
        .padding(.horizontal)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<5, id: \.self) { _ in
                SongCard()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
