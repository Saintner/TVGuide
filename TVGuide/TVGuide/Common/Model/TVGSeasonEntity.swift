//
//  TVGSeasonEntity.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation

struct TVGSeasonEntity: TVGEntity {
    var id: Int
    var url: String
    var number: Int?
    var name: String
    var episodeOrder: Int?
    var premiereDate: String?
    var endDate: String?
    var network: TVGShowEntity.Network?
    var webChannel: TVGShowEntity.Network?
    var image: TVGShowEntity.Image?
    var summary: String?
    var _links: TVGShowEntity.Links
    var _embedded: [TVGEpisodeEntity]?
}
