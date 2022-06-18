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
}
