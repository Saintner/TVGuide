//
//  TVGEndpoint.swift
//  TVGuide
//
//  Created by User on 17/06/22.
//

import Foundation

// - base Endpoint handler Struct
struct IBKEndpoint {
    var path: TVGConstants.UrlConstants.EndpointsPath
    var queryItems: [URLQueryItem] = []
}

// - Endpoint extension to compute a url var to define the URLComponetns
extension IBKEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = TVGConstants.UrlConstants.scheme
        components.host = TVGConstants.UrlConstants.host
        components.path = TVGConstants.UrlConstants.EndpointsPath.path(for: path)
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
