//
//  TVGPersonsListRouter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

class TVGPersonsListRouter: TVGRouter {
    
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGPersonsListRouter()
        
        var view: TVGView = TVGPersonsListViewController()
        let presenter: TVGPersonsListPresenter = TVGPersonsListPresenter()
        let interactor: TVGPersonsListInteractor = TVGPersonsListInteractor(networkManager: remoteModelCollection)
        
        
        presenter.router = router
        presenter.view = view
        presenter.delegate = view as? TVGPersonsListPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.delegate = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func routeToShowsListViewController() {
        let router = TVGShowsListRouter.start()
        let vc = router.entry
        entry?.navigationController?.setViewControllers([vc!], animated: true)
    }
}
