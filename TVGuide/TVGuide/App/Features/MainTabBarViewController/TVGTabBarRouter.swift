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
        let router = TVGTabBarRouter()
        
        var view: TVGView = TVGTabBarViewController()
        let presenter: TVGTabBarPresenter = TVGTabBarPresenter()
        let interactor: TVGTabBarInteractor = TVGTabBarInteractor()
        
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func getShowsListViewController() -> UIViewController {
        let router = TVGShowsListRouter.start()
        let vc = router.entry
        return vc!
    }
    
    func getPersonsListViewController() -> UIViewController {
        let router = TVGPersonsListRouter.start()
        let vc = router.entry
        return vc!
    }
}
