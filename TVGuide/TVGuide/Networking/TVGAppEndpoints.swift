//
//  TVGAppEndpoints.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation

enum TVGAppEndpoint {
    case getShows
    case searchShows
}

extension TVGAppEndpoint {
    
    func rawValue() -> String {
        switch self {
        case .getShows:
            return "/" + TGVAPIEndpoints.shows.rawValue
        case .searchShows:
            return "/" + TGVAPIEndpoints.search.rawValue + "/" + TGVAPIEndpoints.shows.rawValue
        }
    }
    
    private enum TGVAPIEndpoints: String {
        case search = "search"
        case singleSearch = "singlesearch"
        case lookup = "lookup"
        case schedule = "schedule"
        case shows = "shows"
        case alternateLists  = "alternatelists"
        case seasons = "seasons"
        case episodes = "episodes"
        case people = "people"
        case updates = "updates"
    }
}
