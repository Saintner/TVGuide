//
//  TVGNetworkManager.swift
//  TVGuide
//
//  Created by User on 17/06/22.
//

import Foundation
import UIKit
import Combine

// - IBKNetworkManagerProtocol defines the base protocol to manage remote API calls

protocol TVGNetworkManagerProtocol: AnyObject{
    // - main fetch from remote function
    func fetch<T>(type: T.Type,
                url: URL) -> AnyPublisher<T, IBKError> where T: Decodable
}

// - IBKNetworkManager a final class to give a fetch an implementation
final class TVGNetworkManager: TVGNetworkManagerProtocol {
    
    // - fetch main implementation
    func fetch<T>(type: T.Type, url: URL) -> AnyPublisher<T, IBKError> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.global(qos: .background))
            .tryMap { response in
                guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                    throw IBKError.statusCode
                }
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ IBKError.map($0)}
            .eraseToAnyPublisher()
    }
}
