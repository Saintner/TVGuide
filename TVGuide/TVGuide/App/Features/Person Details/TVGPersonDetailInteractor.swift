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
    func didFailedFetchindDetails()
}

class TVGPersonDetailInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var personServices: TVGPersonsServices
    
    var delegate: TVGPersonDetailInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.personServices = TVGPersonsServices(networkManager: networkManager)
    }
    
    func getPersonDetails(with id: Int) {
        personServices.fetchPersonDetails(with: id).sink { completion in
            switch completion {
            case .failure(_):
                self.delegate?.didFailedFetchindDetails()
            case .finished:
                break
            }
        } receiveValue: { [weak self] persons in
            self?.delegate?.didFetchPersonDetails(with: persons)
        }.store(in: &cancellables)
    }
}
