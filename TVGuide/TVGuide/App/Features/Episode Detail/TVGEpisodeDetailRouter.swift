//
//  TVGEpisodeDetailRouter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

class TVGEpisodeDetailRouter: TVGRouter {
    
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGEpisodeDetailRouter()
        
        var view: TVGView = TVGEpisodeDetailViewController()
        let presenter: TVGEpisodeDetailPresenter = TVGEpisodeDetailPresenter(episode: data as! TVGEpisodeEntity)
        let interactor: TVGEpisodeDetailInteractor = TVGEpisodeDetailInteractor(networkManager: remoteModelCollection)
        
        
        presenter.router = router
        presenter.view = view
//        presenter.delegate = view as? TVGShowDetailPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
//        interactor.delegate = presenter
        router.entry = view as? EntryPoint
        return router
    }
}
