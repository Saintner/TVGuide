//
//  TVGShowsListRouter.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation

import UIKit

class TVGShowsListRouter: TVGRouter {
    
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGShowsListRouter()
        
        var view: TVGView = TVGShowsListViewController()
        let presenter: TVGShowsListPresenter = TVGShowsListPresenter()
        let interactor: TVGShowsListInteractor = TVGShowsListInteractor(networkManager: remoteModelCollection)
        
        
        presenter.router = router
        presenter.view = view
        presenter.delegate = view as? TVGShowsListPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.delegate = presenter
        router.entry = view as? EntryPoint
        return router
    }
    
    func routeToDetailPostViewController(with show: TVGShowEntity) {
        let router = TVGShowDetailRouter.start(with: show)
        let vc = router.entry
        entry?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func routeToPersonsListViewController() {
        let router = TVGPersonsListRouter.start()
        let vc = router.entry
        entry?.modalPresentationStyle = .overFullScreen
        entry?.present(vc!, animated: true)
//        entry?.navigationController?.pushViewController(vc!, animated: true)
//        entry?.navigationController?.setViewControllers([vc!], animated: true)
        print(entry?.navigationController?.viewControllers)
    }
}
