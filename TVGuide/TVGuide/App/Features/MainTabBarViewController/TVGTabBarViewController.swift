//
//  TVGTabBarViewController.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

class TVGTabBarViewController: UITabBarController, TVGView {
    
    var presenter: TVGPresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.viewControllers?.count == nil {
            let presenter = presenter as! TVGTabBarPresenter
            
            let firstTab = presenter.getShowsListViewController()
            let tabBarShowsItem = UITabBarItem(title: TVGConstants.tabBarShowsTitle, image: UIImage(systemName: TVGConstants.tvIcon), selectedImage: nil)
            firstTab.tabBarItem = tabBarShowsItem
            
            let secondTab = presenter.getPersonsListViewController()
            let tabBarPersonsItem = UITabBarItem(title: TVGConstants.tabBarPersonsTitle, image: UIImage(systemName: TVGConstants.personIcon), selectedImage: nil)
            secondTab.tabBarItem = tabBarPersonsItem
            
            self.viewControllers = [firstTab, secondTab]
            self.navigationItem.title = tabBarShowsItem.title
        }
    }

}

extension TVGTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
}
