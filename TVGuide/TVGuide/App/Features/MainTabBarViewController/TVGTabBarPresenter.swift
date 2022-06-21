//
//  TVGTabBarPresenter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

class TVGTabBarPresenter: TVGPresenter {
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    func getShowsListViewController() -> UIViewController {
        let router = router as! TVGTabBarRouter
        return router.getShowsListViewController()
    }
    
    func getPersonsListViewController() -> UIViewController {
        let router = router as! TVGTabBarRouter
        return router.getPersonsListViewController()
    }
}
