//
//  TVGShowsListInteractor.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import Combine

protocol TVGShowsListInteractorDelegate {
    func didFetchPostList(with posts: [TVGShowEntity])
}

class TVGShowsListInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showsServices: TVGShowsServices
    
    var delegate: TVGShowsListInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showsServices = TVGShowsServices(networkManager: networkManager)
    }
    
    func fetchShowsList() {
        showsServices.fetchShows().sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] shows in
            self?.delegate?.didFetchPostList(with: [shows])
        }.store(in: &cancellables)
    }
    
}
