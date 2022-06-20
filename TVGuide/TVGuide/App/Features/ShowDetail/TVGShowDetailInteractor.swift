//
//  TVGShowDetailInteractor.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import Combine

protocol TVGShowDetailInteractorDelegate {
}

class TVGShowDetailInteractor: TVGInteractor {
    var presenter: TVGPresenter?
    var showServices: TVGShowsServices
    
    var delegate: TVGShowDetailInteractorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: TVGNetworkManagerProtocol) {
        self.showServices = TVGShowsServices(networkManager: networkManager)
    }
}
