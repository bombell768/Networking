//
//  TVShowViewModel.swift
//  Networking
//
//  Created by Bartosz Strzecha on 08/07/2025.
//

import Foundation

final class TVShowViewModel {
    private let service: TMDBServiceProtocol
    private(set) var shows: [TVShow] = []
    
    init(service: TMDBServiceProtocol) {
        self.service = service
    }
    
    func fetchTVShows(completion: @escaping (TMDBError?) -> Void) {
        service.fetchTopRatedTVShows { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self?.shows = shows
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    func imageURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
