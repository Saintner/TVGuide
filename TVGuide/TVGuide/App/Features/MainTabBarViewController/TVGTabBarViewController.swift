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
        let presenter = presenter as! TVGTabBarPresenter
        let tabOne = presenter.getShowsListViewController()
               let tabOneBarItem = UITabBarItem(title: "Shows", image: nil, selectedImage: nil)
        
        tabOne.view.backgroundColor = .blue
               tabOne.tabBarItem = tabOneBarItem
               
               
               // Create Tab two
        let tabTwo = presenter.getPersonsListViewController()
        tabTwo.view.backgroundColor = .green
               let tabTwoBarItem2 = UITabBarItem(title: "Persons", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
               
               tabTwo.tabBarItem = tabTwoBarItem2
               
               
               self.viewControllers = [tabOne, tabTwo]
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
