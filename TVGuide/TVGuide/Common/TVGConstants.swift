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
    }
    static var defaultCellReuseIdentifier = "cell"
    static var textFieldSearchPlaceholder = "Search"
    static var tabBarShowsTitle = "Shows"
    static var tabBarPersonsTitle = "Persons"
    static var tvIcon =  "play.tv"
    static var personIcon =  "person.2"
    static var emptyPersonShows = "There is not shows data available"
}
