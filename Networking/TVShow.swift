//
//  TVShow.swift
//  Networking
//
//  Created by Bartosz Strzecha on 08/07/2025.
//

struct TVShowsResponse: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let name: String
    let description: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
