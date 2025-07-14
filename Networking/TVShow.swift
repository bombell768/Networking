//
//  TVShow.swift
//  Networking
//
//  Created by Bartosz Strzecha on 08/07/2025.
//

import Foundation

struct TVShowsResponse: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let name: String
    let firstAirDate: String
    let rating: Double
    let originCountry: [String]
    let popularity: Double
    let description: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAirDate = "first_air_date"
        case rating = "vote_average"
        case originCountry = "origin_country"
        case popularity
        case description = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
