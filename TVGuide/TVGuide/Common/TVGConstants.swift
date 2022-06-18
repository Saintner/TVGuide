//
//  TVGConstants.swift
//  TVGuide
//
//  Created by User on 17/06/22.
//

import Foundation

// - A struct to stored all app constants
struct TVGConstants {
    struct UrlConstants {
        static var scheme = "https"
        static var host = "api.tvmaze.com"
        enum EndpointsPath: String {
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
            static func path(for basePath: EndpointsPath) -> String {
                return basePath.rawValue
            }
        }
    }
    static var defaultCellReuseIdentifier = "cell"
    static var textFieldSearchPlaceholder = "Search"
}
