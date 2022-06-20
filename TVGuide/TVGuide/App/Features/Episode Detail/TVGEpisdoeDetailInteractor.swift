//
//  TVGEpisdoeDetailInteractor.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

protocol TVGEpisodeDetailInteractorDelegate {
    func didFetchEpisode(with episode: TVGEpisodeEntity)
}

class TVGEpisodeDetailInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    
    var showServices: TVGEpisodesServices
    
    var delegate: TVGEpisodeDetailInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showServices = TVGEpisodesServices(networkManager: networkManager)
    }
    
//    func fetchEpisode(with id: Int){
//        showServices.fetchEpisode(with: id).sink { completion in
//                switch completion {
//                case .failure(let error):
//                    print(error)
//                case .finished:
//                    break
//                }
//            } receiveValue: { [weak self] shows in
//                self?.delegate?.didFetchEpisode(with: shows)
//            }.store(in: &cancellables)
//    }
}
