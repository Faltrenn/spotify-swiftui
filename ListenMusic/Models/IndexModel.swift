//
//  IndexModel.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import Foundation

struct Song : Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let file: String
    let image: String
    let artist: Artist
}

struct Artist: Codable, Hashable {
    let id: Int
    let name: String
}
