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
    static func shows(with page:String) -> Self {
        let queryItem = URLQueryItem(name: "page", value: page)
        return TVGEndpoint(endpoint: .getShows, queryItems: [queryItem])
    }
    
    static func searchShows(with text:String) -> Self {
        let queryItem = URLQueryItem(name: "q", value: text)
        return TVGEndpoint(endpoint: .searchShows, queryItems: [queryItem])
    }
    
    static func seasons(with id:Int) -> Self {
        let queryItem = URLQueryItem(name: "embed", value: "episodes")
        return TVGEndpoint(endpoint: .getSeasons(id: id), queryItems: [queryItem])
    }
    
    static func episodes(with id:Int) -> Self {
        return TVGEndpoint(endpoint: .getEpisodes(id: id))
    }
    
    static func persons(with page:String) -> Self {
        let queryItem = URLQueryItem(name: "page", value: page)
        return TVGEndpoint(endpoint: .getPersons, queryItems: [queryItem])
    }
    
    static func searchPersons(with text:String) -> Self {
        let queryItem = URLQueryItem(name: "q", value: text)
        return TVGEndpoint(endpoint: .searchPersons, queryItems: [queryItem])
    }
    
    static func personShows(with id: Int) -> Self {
        let queryItem = URLQueryItem(name: "embed", value: "show")
        return TVGEndpoint(endpoint: .getPersonShows(id: id), queryItems: [queryItem])
    }
}

// - Endpoint extension to compute a url var to define the URLComponetns
extension TVGEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = TVGConstants.UrlConstants.scheme
        components.host = TVGConstants.UrlConstants.host
        components.path = endpoint.rawValue()
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
