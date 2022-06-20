//
//  TVGShowDetailPresenter.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation

protocol TVGShowDetailPresenterDelegate {
}

class TVGShowDetailPresenter: TVGPresenter {
    
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    var delegate: TVGShowDetailPresenterDelegate?
    private var show: TVGShowEntity
    private var episodesShow: Int = 100
    
    init(show: TVGShowEntity) {
        self.show = show
    }
    
    func viewDidLoad() {
        
    }
    
    func getShowTitle() -> String {
        return show.name
    }
    
    func getImageURL() -> URL? {
        let url = URL(string: show.image?.original ?? "")
        return url
    }
    
    func getEpisodesCount() -> Int {
        return episodesShow
    }
    
    func getEpisodeTitle() -> String {
        return "Hello"
    }
    
    func getDaysAndTimeAired() -> String {
        let days = getDaysAiredText()
        let time = show.schedule.time
        return "Watch every \(days) at \(time)"
    }
    
    func getGenres() -> String {
        var genres = ""
        let genresMapper = show.genres.map { genre in
            return genre.rawValue
        }
        for genre in genresMapper {
            genres = genres + genre + ", "
        }
        genres.removeLast(2)
        return genres
    }
    
    func getSummaryTitle() -> String? {
        return show.summary
    }
    
    private func getDaysAiredText() -> String {
        var days = ""
        for day in show.schedule.days {
            days = days + day + ", "
        }
        return days
    }
}

extension TVGShowDetailPresenter: TVGShowDetailInteractorDelegate {
    
}
