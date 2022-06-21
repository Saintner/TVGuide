//
//  TVGPersonsListViewController.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit
import SDWebImage

class TVGPersonsListViewController: UIViewController, TVGView {
    
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
        
        let presenter = presenter as! TVGPersonsListPresenter
        presenter.viewDidLoad()
        self.navigationItem.title = TVGConstants.tabBarPersonsTitle
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

extension TVGPersonsListViewController: TVGPersonsListPresenterDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}


extension TVGPersonsListViewController: TVGShowsListHeaderViewTableViewDelegate{
    func didChangeTextfield(with text: String) {
        guard let presenter = presenter as? TVGPersonsListPresenter else { return }
        presenter.filterPersons(with: text)
    }
}
