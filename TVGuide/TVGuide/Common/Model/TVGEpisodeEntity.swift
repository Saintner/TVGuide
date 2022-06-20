//
//  TVGEpisodeEntity.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation

struct TVGEpisodeEntity: TVGEntity {
    var id: Int
    var url: String
    var name: String
    var season: Int
    var number: Int?
    var type: String
    var airdate: String
    var airtime: String
    var airstamp: String
    var runtime: Int
    var rating: TVGShowEntity.Rating
    var image: TVGShowEntity.Image?
    var summary: String?
    var _links: TVGShowEntity.Links
}
