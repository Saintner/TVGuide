//
//  TVGShowDetailPresenter.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation

protocol TVGShowDetailPresenterDelegate {
    func reloadTableView()
}

class TVGShowDetailPresenter: TVGPresenter {
    
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    var delegate: TVGShowDetailPresenterDelegate?
    private var show: TVGShowEntity
    private var seasons: [Int] = []
    private var episodesShow: Int = 5
    private var seasonsEpisodes: [SeasonEpisodes] = []
    private struct SeasonEpisodes {
        var id: Int
        var episodes: TVGEpisodeEntity
    }
    
    init(show: TVGShowEntity) {
        self.show = show
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async {
            let interactor = self.interactor as! TVGShowDetailInteractor
            interactor.fetchSeasons(with: self.show.id)
        }
    }
    
    func getShowTitle() -> String {
        return show.name
    }
    
    func getImageURL() -> URL? {
        let url = URL(string: show.image?.original ?? "")
        return url
    }
    
    func getSeasonsCount() -> Int {
        return seasons.count
    }
    
    func getSeasonNumber(at row: Int) -> String {
        let seasonNumber = seasons[row]
        return "Season \(seasonNumber)"
    }
    
    func getEpisodesCount(for season: Int) -> Int {
        let episodes = seasonsEpisodes.filter({$0.episodes.season == seasons[season]})
        return  episodes.count
    }
    
    func getEpisodeTitle(for season: Int, at row: Int) -> String? {
        let episodes = seasonsEpisodes.filter({$0.episodes.season == seasons[season]})
        let episode = episodes[row]
        return episode.episodes.name
    }
    
    func getDaysAndTimeAired() -> String {
        let days = getDaysAiredText()
        let time = show.schedule.time
        if time.count > 0 {
            return "Watch every \(days) at \(time)"
        }else {
            return "Watch every \(days)"
        }
    }
    
    func getGenres() -> String {
        var genres = ""
        let genresMapper = show.genres.map { genre in
            return genre.rawValue
        }
        for genre in genresMapper {
            let index = genresMapper.firstIndex(of: genre)
            genres = (index! + 1) == genresMapper.count ? genres + genre : genres + genre + ", "
        }
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
    
    func didSelectEpisode(for season:Int, at row: Int){
        let episodes = seasonsEpisodes.filter({$0.episodes.season == seasons[season]})
        let episode = episodes[row]
            let routing = router as! TVGShowDetailRouter
        routing.routeToEpisodeDetailViewController(with: episode.episodes)
    }
}

extension TVGShowDetailPresenter: TVGShowDetailInteractorDelegate {
    
    func didFetchSeasonsList(with seasons: [TVGEpisodeEntity]) {
            for season in seasons {
                let episode = SeasonEpisodes(id: season.season, episodes: season)
                seasonsEpisodes.append(episode)
            }
        
        let seasonsIds = seasons.map { season in
                return season.season
            }
        self.seasons = seasonsIds.unique()
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }
    
}
