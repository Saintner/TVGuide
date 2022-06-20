//
//  TVGShowDetailRouter.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import UIKit

class TVGShowDetailRouter: TVGRouter {
    
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGShowDetailRouter()
        
        var view: TVGView = TVGShowDetailViewController()
        let presenter: TVGShowDetailPresenter = TVGShowDetailPresenter(show: data as! TVGShowEntity)
        let interactor: TVGShowDetailInteractor = TVGShowDetailInteractor(networkManager: remoteModelCollection)
        
        
        presenter.router = router
        presenter.view = view
        presenter.delegate = view as? TVGShowDetailPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.delegate = presenter
        router.entry = view as? EntryPoint
        return router
    }
}
