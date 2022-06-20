//
//  TVGShowDetailInteractor.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import Combine

protocol TVGShowDetailInteractorDelegate {
    func didFetchSeasonsList(with seasons: [TVGSeasonEntity])
    func didFetchEpisodesSeason(for id: Int, with episodes: [TVGEpisodeEntity])
}

class TVGShowDetailInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showServices: TVGShowsServices
    
    var delegate: TVGShowDetailInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showServices = TVGShowsServices(networkManager: networkManager)
    }
    
    func fetchSeasons(with id: Int){
        showServices.fetchSeasons(with: id).sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] shows in
                self?.delegate?.didFetchSeasonsList(with: shows)
            }.store(in: &cancellables)
    }
    
    func fetchSeasonEpisodes(with id: Int){
        showServices.fetchSeasonEpisodes(with: id).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] episodes in
            self?.delegate?.didFetchEpisodesSeason(for: id, with: episodes)
        }.store(in: &cancellables)
    }
}