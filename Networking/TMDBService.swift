//
//  TMDBService.swift
//  Networking
//
//  Created by Bartosz Strzecha on 08/07/2025.
//

import Foundation

enum TMDBError: Error {
    case invalidURL
    case networkError
    case decodingError
    case noData

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .networkError: return "Network connection failed."
        case .decodingError: return "Data decoding failed."
        case .noData: return "No data returned."
        }
    }
}

final class TMDBService {
    static let shared = TMDBService()
    private let baseURL = "https://api.themoviedb.org/3/tv/top_rated"
    private let apiKey = "7481bbcf1fcb56bd957cfe9af78205f3"
    
    func fetchTopRatedTVShows(completion: @escaping (Result<[TVShow], TMDBError>) -> Void) {
        guard var components = URLComponents(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(TVShowsResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
