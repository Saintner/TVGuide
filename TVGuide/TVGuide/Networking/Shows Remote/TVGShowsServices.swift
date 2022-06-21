//
//  TVGShowsServices.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import Combine

// - TVGShowsServicesProtocol takes networkManager as a TVGNetworkManagerProtocol property and
// - fetchShows method as AnyPublisher<[TVGShowEntity],TVGError>
protocol TVGShowsServicesProtocol {
    var networkManager: TVGNetworkManagerProtocol { get set }
    
    func fetchShows(with page: Int) -> AnyPublisher<[TVGShowEntity],TVGError>
    
    func fetchSearchedShows(with text: String) -> AnyPublisher<[TVGSearchedShowEntity],TVGError>
    
    func fetchSeasons(with id: Int) -> AnyPublisher<[TVGEpisodeEntity],TVGError>
    
    func fetchSeasonEpisodes(with id: Int) -> AnyPublisher<[TVGEpisodeEntity],TVGError>
}

// - TVGShowsServices final class to handle Show entity Remote Services
final class TVGShowsServices: TVGShowsServicesProtocol {
    
    var networkManager: TVGNetworkManagerProtocol
    
    init(networkManager: TVGNetworkManagerProtocol) {
            self.networkManager = networkManager
    }
    
    func fetchShows(with page: Int) -> AnyPublisher<[TVGShowEntity], TVGError> {
        let endpoint = TVGEndpoint.shows(with: "\(page)")
        return networkManager.fetchArray(type: [TVGShowEntity].self, url: endpoint.url)
    }
    
    func fetchSearchedShows(with text: String) -> AnyPublisher<[TVGSearchedShowEntity],TVGError> {
        let endpoint = TVGEndpoint.searchShows(with: text)
        return networkManager.fetchArray(type: [TVGSearchedShowEntity].self, url: endpoint.url)
    }
    
    func fetchSeasons(with id: Int) -> AnyPublisher<[TVGEpisodeEntity],TVGError>{
        let endpoint = TVGEndpoint.seasons(with: id)
        return networkManager.fetchArray(type: [TVGEpisodeEntity].self, url: endpoint.url)
    }
    
    func fetchSeasonEpisodes(with id: Int) -> AnyPublisher<[TVGEpisodeEntity],TVGError>{
        let endpoint = TVGEndpoint.episodes(with: id)
        return networkManager.fetchArray(type: [TVGEpisodeEntity].self, url: endpoint.url)
    }
}
