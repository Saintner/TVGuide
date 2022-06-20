//
//  TVGTabBarRouter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

class TVGTabBarRouter: TVGRouter {
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGTabBarRouter()
        
        var view: TVGView = TVGTabBarViewController()
        let presenter: TVGTabBarPresenter = TVGTabBarPresenter()
        let interactor: TVGTabBarInteractor = TVGTabBarInteractor()
        
        
        presenter.router = router
        presenter.view = view
//        presenter.delegate = view as? TVGPersonsListPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
//        interactor.delegate = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func routeToShowsListViewController() -> UIViewController {
        let router = TVGShowsListRouter.start()
        let vc = router.entry
        return vc!
    }
    
    func routeToPersonsListViewController() -> UIViewController {
        let router = TVGPersonsListRouter.start()
        let vc = router.entry
        return vc!
    }
}
