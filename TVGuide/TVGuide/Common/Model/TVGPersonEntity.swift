//
//  TVGPersonEntity.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation

struct TVGPersonEntity: TVGEntity {
    var id: Int
    var url: String
    var name: String
    var country: TVGShowEntity.Network.TVGCountry?
    var birthday: String?
    var deathday: String?
    var gender: String?
    var image: TVGShowEntity.Image?
    var updated: Int?
    var _links: TVGShowEntity.Links
}

struct TVGSearchedPersonEntity: TVGEntity {
    var score: Double?
    var person: TVGPersonEntity
}
