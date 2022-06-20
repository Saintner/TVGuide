//
//  TVGPersonsServices.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

// - TVGShowsServicesProtocol takes networkManager as a IBKNetworkManagerProtocol property and
// - fetchPosts method as AnyPublisher<IBKPosts,IBKError>
protocol TVGPersonsServicesProtocol {
    var networkManager: TVGNetworkManagerProtocol { get set }
    
    func fetchPersons(with page: Int) -> AnyPublisher<[TVGPersonEntity],TVGError>
    
    func fetchSearchedPersons(with text: String) -> AnyPublisher<[TVGSearchedPersonEntity],TVGError>
}

// - TVGShowsServices final class to handle Post entity Remote Services
final class TVGPersonsServices: TVGPersonsServicesProtocol {
    
    var networkManager: TVGNetworkManagerProtocol
    
    init(networkManager: TVGNetworkManagerProtocol) {
            self.networkManager = networkManager
    }
    
    func fetchPersons(with page: Int) -> AnyPublisher<[TVGPersonEntity], TVGError> {
        let endpoint = TVGEndpoint.persons(with: "\(page)")
        return networkManager.fetchArray(type: [TVGPersonEntity].self, url: endpoint.url)
    }
    
    func fetchSearchedPersons(with text: String) -> AnyPublisher<[TVGSearchedPersonEntity],TVGError> {
        let endpoint = TVGEndpoint.searchPersons(with: text)
        return networkManager.fetchArray(type: [TVGSearchedPersonEntity].self, url: endpoint.url)
    }
}
