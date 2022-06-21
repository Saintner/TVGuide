//
//  TVGShowDetailInteractor.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import Combine

protocol TVGShowDetailInteractorDelegate {
    func didFetchSeasonsList(with seasons: [TVGEpisodeEntity])
    func didFailedFetching()
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
                case .failure(_):
                    self.delegate?.didFailedFetching()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] shows in
                self?.delegate?.didFetchSeasonsList(with: shows)
            }.store(in: &cancellables)
    }
}
