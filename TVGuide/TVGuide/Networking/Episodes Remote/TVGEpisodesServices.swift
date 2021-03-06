//
//  TVGEpisodesServices.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

// - TVGEpisodesServicesProtocol takes networkManager as a TVGNetworkManagerProtocol property and
// - fetchEpisode method as AnyPublisher<TVGEpisodeEntity, TVGError>
protocol TVGEpisodesServicesProtocol {
    var networkManager: TVGNetworkManagerProtocol { get set }
    
    func fetchEpisode(with id:Int) -> AnyPublisher<TVGEpisodeEntity, TVGError>
}

// - TVGShowsServices final class to handle Episodes entity Remote Services
final class TVGEpisodesServices: TVGEpisodesServicesProtocol {
    
    var networkManager: TVGNetworkManagerProtocol
    
    init(networkManager: TVGNetworkManagerProtocol) {
            self.networkManager = networkManager
    }
    
    func fetchEpisode(with id:Int) -> AnyPublisher<TVGEpisodeEntity, TVGError> {
        let endpoint = TVGEndpoint.episodes(with: id)
        return networkManager.fetch(type: TVGEpisodeEntity.self, url: endpoint.url)
    }
}

