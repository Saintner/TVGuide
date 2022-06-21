//
//  TVGPersonDetailInteractor.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

protocol TVGPersonDetailInteractorDelegate {
    func didFetchPersonDetails(with details: [TVGPersonShowsEntity])
//    func didFetchSearchedPersonsList(with searchedShows: [TVGPersonEntity])
//    func didFailedFetch()
}

class TVGPersonDetailInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showsServices: TVGPersonsServices
    
    var delegate: TVGPersonDetailInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showsServices = TVGPersonsServices(networkManager: networkManager)
    }
    
    func getPersonDetails(with id: Int) {
        showsServices.fetchPersonDetails(with: id).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] persons in
            self?.delegate?.didFetchPersonDetails(with: persons)
        }.store(in: &cancellables)
    }
}
