//
//  IndexModel.swift
//  ListenMusic
//
//  Created by Emanuel on 14/06/23.
//

import Foundation

struct Song : Codable {
    let id: Int
    let name: String
    let file: String
    let image: String
    let artist: Artist
}

struct Artist: Codable {
    let id: Int
    let name: String
}
