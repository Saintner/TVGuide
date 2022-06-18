//
//  TVGEndpoint.swift
//  TVGuide
//
//  Created by User on 17/06/22.
//

import Foundation

// - base Endpoint handler Struct
struct TVGEndpoint {
    var endpoint: TVGAppEndpoint
    var queryItems: [URLQueryItem] = []
}

extension TVGEndpoint {
    static var shows: Self {
        return TVGEndpoint(endpoint: .getShows)
    }
}

// - Endpoint extension to compute a url var to define the URLComponetns
extension TVGEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = TVGConstants.UrlConstants.scheme
        components.host = TVGConstants.UrlConstants.host
        print(endpoint.rawValue())
        components.path = endpoint.rawValue()
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
