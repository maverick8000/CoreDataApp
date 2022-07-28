//
//  AlbumPage.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import Foundation

struct AlbumPage: Decodable {
    
    let feed: Results
    
}

struct Results: Decodable {
    
    let results: [Album]
}

struct Album: Decodable {
    
    let artistName: String
    
    let name: String
    
    let artworkUrl100: String
}
