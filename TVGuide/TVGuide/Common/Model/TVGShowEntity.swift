//
//  TVGShowsEntity.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation

struct TVGShowEntity: TVGEntity {
    var id: Int
    var url: String
    var name: String
    var type: String
    var language: String
    var genres: [TVGGenre]
    var status: String
    var runtime: Int?
    var averageRuntime: Int
    var premiered: String
    var ended: String?
    var officialSite: String?
    var schedule: Schedule
    var rating: Rating
    var weight: Int
    var network: Network?
    var webChannel: Network?
    var dvdCountry: Network.TVGCountry?
    var externals: Externals
    var image: Image
    var summary: String
    var updated: Int
    var _links: Links
    struct Schedule: TVGEntity {
        var time: String
        var days: [String]
    }
    
    struct Rating: TVGEntity {
        var average: Double?
    }
    
    struct Network : TVGEntity {
        var id: Int
        var name: String
        var country: TVGCountry?
        var officialSite: String?
        struct TVGCountry: TVGEntity {
            var name: String
            var code: String
            var timezone: String
        }
    }
    
    struct Externals: TVGEntity {
        var tvrage: Int
        var thetvdb: Int?
        var imdb: String?
    }
    
    struct Image: TVGEntity {
        var medium: String
        var original: String
    }
    
    struct Links: TVGEntity {
        var `self`: Self
        var previousepisode: PreviousEpisode
        struct `Self`: TVGEntity {
            var href: String
        }
        struct PreviousEpisode: TVGEntity {
            var href: String
        }
    }
}
