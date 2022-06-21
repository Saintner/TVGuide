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
            let tabOne = presenter.getShowsListViewController()
                   let tabOneBarItem = UITabBarItem(title: "Shows", image: nil, selectedImage: nil)
            
            tabOne.view.backgroundColor = .blue
                   tabOne.tabBarItem = tabOneBarItem
                   
            
                   // Create Tab two
            let tabTwo = presenter.getPersonsListViewController()
            tabTwo.view.backgroundColor = .green
                   let tabTwoBarItem2 = UITabBarItem(title: "Persons", image: nil, selectedImage: nil)
                   
                   tabTwo.tabBarItem = tabTwoBarItem2
                   
                   
                   self.viewControllers = [tabOne, tabTwo]
            self.navigationItem.title = tabOneBarItem.title
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TVGTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
}
