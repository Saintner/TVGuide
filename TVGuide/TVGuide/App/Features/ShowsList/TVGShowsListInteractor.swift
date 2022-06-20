//
//  TVGShowsListInteractor.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import Combine

protocol TVGShowsListInteractorDelegate {
    func didFetchShowsList(with shows: [TVGShowEntity])
    func didFetchSearchedShowsList(with searchedShows: [TVGShowEntity])
}

class TVGShowsListInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showsServices: TVGShowsServices
    
    var delegate: TVGShowsListInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showsServices = TVGShowsServices(networkManager: networkManager)
    }
    
    func fetchShowsList(with page:Int = 1) {
        showsServices.fetchShows(with: page).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] shows in
            self?.delegate?.didFetchShowsList(with: shows)
        }.store(in: &cancellables)
    }
    
    func fetchSearchShowsList(with text:String){
        showsServices.fetchSearchedShows(with: text).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] shows in
            let showsMapper = shows.map { searchedShow -> TVGShowEntity in
                return searchedShow.show
            }
            self?.delegate?.didFetchSearchedShowsList(with: showsMapper)
        }.store(in: &cancellables)
    }
    
    
}
