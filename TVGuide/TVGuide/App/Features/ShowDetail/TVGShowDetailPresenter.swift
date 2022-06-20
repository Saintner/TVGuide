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
    private var seasons: [TVGSeasonEntity] = []
    private var episodesShow: Int = 5
    private var seasonsEpisodes: [SeasonEpisodes] = []
    private struct SeasonEpisodes {
        var id: Int
        var episodes: [TVGEpisodeEntity]
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
        let seasonNumber = seasons[row].number
        return "Season \(seasonNumber ?? row)"
    }
    
    func getEpisodesCount(for season: Int) -> Int {
        let episodes = seasonsEpisodes.first(where: { $0.id == seasons[season].id }).map({ return $0.episodes })
        return episodes?.count ?? 0
    }
    
    func getEpisodeTitle(for season: Int, at row: Int) -> String? {
        let episode = seasonsEpisodes.first(where: { $0.id == seasons[season].id }).map({ return $0.episodes[row]})
        return "\(episode?.number ?? 0). " + (episode?.name ?? "")
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
    
    func didFetchEpisodesSeason(for id: Int, with episodes: [TVGEpisodeEntity]) {
        let episode = SeasonEpisodes(id: id, episodes: episodes)
        seasonsEpisodes.append(episode)
        if seasonsEpisodes.count == seasons.count {
                    DispatchQueue.main.async {
                        self.delegate?.reloadTableView()
                    }
        }
    }
    
    func didFetchSeasonsList(with seasons: [TVGSeasonEntity]) {
        self.seasons = seasons
        DispatchQueue.global(qos: .background).async {
            let interactor = self.interactor as! TVGShowDetailInteractor
            for season in seasons {
                interactor.fetchSeasonEpisodes(with: season.id)
            }
        }
    }
    
}
