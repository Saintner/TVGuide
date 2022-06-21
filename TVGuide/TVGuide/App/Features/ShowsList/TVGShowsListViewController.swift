//
//  ViewController.swift
//  TVGuide
//
//  Created by Eris Ramirez on 17/06/22.
//

import UIKit
import SDWebImage

class TVGShowsListViewController: UIViewController, TVGView {
    
    var presenter: TVGPresenter?
    
    internal var tableHeader = TVGShowsListHeaderViewTableView()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: TVGConstants.defaultCellReuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = presenter as! TVGShowsListPresenter
        presenter.viewDidLoad()
        self.navigationItem.title = TVGConstants.tabBarShowsTitle
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        let topAnchor = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let bottomAnchor = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, bottomAnchor])
    }


}

extension TVGShowsListViewController: TVGShowsListPresenterDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}


extension TVGShowsListViewController: TVGShowsListHeaderViewTableViewDelegate{
    func didChangeTextfield(with text: String) {
        guard let presenter = presenter as? TVGShowsListPresenter else { return }
        presenter.filterPosts(with: text)
    }
}
