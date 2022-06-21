//
//  TVGPersonDetailRouter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation

class TVGPersonDetailRouter: TVGRouter {
    var remoteModelCollection: TVGNetworkManager?
    
    var entry: EntryPoint?
    var data: TVGEntity?
    
    static func start(with data: TVGEntity? = nil) -> TVGRouter {
        let remoteModelCollection = TVGNetworkManager()
        let router = TVGPersonDetailRouter()
        
        var view: TVGView = TVGPersonDetailViewController()
        let presenter: TVGPersonDetailPresenter = TVGPersonDetailPresenter(show: data as! TVGPersonEntity)
        let interactor: TVGPersonDetailInteractor = TVGPersonDetailInteractor(networkManager: remoteModelCollection)
        
        
        presenter.router = router
        presenter.view = view
        presenter.delegate = view as? TVGPersonDetailPresenterDelegate
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.delegate = presenter
        
        router.entry = view as? EntryPoint
        return router
    }
    
    func routeToShowDetailViewController(with show: TVGShowEntity) {
        let router = TVGShowDetailRouter.start(with: show)
        let vc = router.entry
        entry?.navigationController?.pushViewController(vc!, animated: true)}
}
