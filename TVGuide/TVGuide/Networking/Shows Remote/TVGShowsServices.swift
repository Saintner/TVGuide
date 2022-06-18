//
//  TVGShowsServices.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import Combine

// - TVGShowsServicesProtocol takes networkManager as a IBKNetworkManagerProtocol property and
// - fetchPosts method as AnyPublisher<IBKPosts,IBKError>
protocol TVGShowsServicesProtocol {
    var networkManager: TVGNetworkManagerProtocol { get set }
    
    func fetchShows() -> AnyPublisher<TVGShowEntity,TVGError>
}

// - TVGShowsServices final class to handle Post entity Remote Services
final class TVGShowsServices: TVGShowsServicesProtocol {
    
    var networkManager: TVGNetworkManagerProtocol
    
    init(networkManager: TVGNetworkManagerProtocol) {
            self.networkManager = networkManager
    }

    
    func fetchShows() -> AnyPublisher<TVGShowEntity, TVGError> {
        let endpoint = TVGEndpoint.shows
        return networkManager.fetch(type: TVGShowEntity.self, url: endpoint.url)
    }
    
}