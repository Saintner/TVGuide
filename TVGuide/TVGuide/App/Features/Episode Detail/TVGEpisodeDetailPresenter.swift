//
//  TVGEpisodeDetailPresenter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation

class TVGEpisodeDetailPresenter: TVGPresenter {
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    private var episode: TVGEpisodeEntity
    
    init(episode: TVGEpisodeEntity) {
        self.episode = episode
    }
    
    func getEpisodeName() -> String? {
        return episode.name
    }
    
    func getEpisodeNumber() -> String? {
        if let number = episode.number {
            return "Episode º\(number)"
        }else {
            return ""
        }
    }
    
    func getEpisodeSeason() -> String? {
        return "Season \(episode.season)"
    }
    
    func getEpisodeSummary() -> String? {
        return episode.summary
    }
    
    func getEpisodeImageURL() -> URL? {
        if let urlString = episode.image?.medium {
            let url = URL(string: urlString)
            return url
        }else {
            return nil
        }
    }
}
