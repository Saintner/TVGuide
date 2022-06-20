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
    case getSeasons(id: Int)
    case getEpisodes(id: Int)
}

extension TVGAppEndpoint {
    
    func rawValue() -> String {
        switch self {
        case .getShows:
            return "/" + TVGAPIEndpoints.shows.rawValue
        case .searchShows:
            return "/" + TVGAPIEndpoints.search.rawValue + "/" + TVGAPIEndpoints.shows.rawValue
        case .getSeasons(let id):
            return "/" + TVGAPIEndpoints.shows.rawValue + "/\(id)/" + TVGAPIEndpoints.episodes.rawValue
        case .getEpisodes(let id):
            return "/" + TVGAPIEndpoints.seasons.rawValue + "/\(id)/" + TVGAPIEndpoints.episodes.rawValue 
        }
    }
    
    private enum TVGAPIEndpoints: String {
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
