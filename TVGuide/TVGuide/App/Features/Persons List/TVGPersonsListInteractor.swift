//
//  TVGPersonsListInteractor.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

protocol TVGPersonsListInteractorDelegate {
    func didFetchPersonsList(with shows: [TVGPersonEntity])
    func didFetchSearchedPersonsList(with searchedShows: [TVGPersonEntity])
    func didFailedFetch()
}

class TVGPersonsListInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showsServices: TVGPersonsServices
    
    var delegate: TVGPersonsListInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showsServices = TVGPersonsServices(networkManager: networkManager)
    }
    
    func fetchPersonsList(with page:Int = 1) {
        showsServices.fetchPersons(with: page).sink { completion in
            switch completion {
            case .failure(_):
                self.delegate?.didFailedFetch()
            case .finished:
                break
            }
        } receiveValue: { [weak self] persons in
            self?.delegate?.didFetchPersonsList(with: persons)
        }.store(in: &cancellables)
    }
    
    func fetchSearchPersonsList(with text:String){
        showsServices.fetchSearchedPersons(with: text).sink { completion in
            switch completion {
            case .failure(_):
                self.delegate?.didFailedFetch()
            case .finished:
                break
            }
        } receiveValue: { [weak self] persons in
            let showsMapper = persons.map { searchedShow -> TVGPersonEntity in
                return searchedShow.person
            }
            self?.delegate?.didFetchSearchedPersonsList(with: showsMapper)
        }.store(in: &cancellables)
    }
    
    
}

