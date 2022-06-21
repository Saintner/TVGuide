//
//  TVGPersonShowsEntity.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation

struct TVGPersonShowsEntity: TVGEntity {
    var `self`: Bool
    var voice: Bool
    var _links: Links?
    var _embedded: Embedded
    
    struct Embedded : TVGEntity {
        var show: TVGShowEntity
    }
    
    struct Links: TVGEntity {
        var show: Show
        var character: Character?
        struct Show: TVGEntity {
            var href: String
        }
        struct Character: TVGEntity {
            var href: String
        }
    }
}
