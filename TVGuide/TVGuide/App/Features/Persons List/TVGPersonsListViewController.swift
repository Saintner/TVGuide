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
        self.navigationItem.title = "Persons"
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

extension TVGPersonsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableHeader.delegate = self
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
               let presenter = presenter as! TVGPersonsListPresenter
                presenter.loadNewPage()
            }
    }
}


extension TVGPersonsListViewController: TVGShowsListHeaderViewTableViewDelegate{
    func didChangeTextfield(with text: String) {
        guard let presenter = presenter as? TVGPersonsListPresenter else { return }
        presenter.filterPersons(with: text)
    }
}

extension TVGPersonsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter as? TVGPersonsListPresenter else { return 0 }
        return presenter.getPostsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVGConstants.defaultCellReuseIdentifier, for: indexPath)
        guard let presenter = presenter as? TVGPersonsListPresenter else { return cell }
        cell.textLabel!.text =  presenter.getPostTitle(at: indexPath.row)
        let row = indexPath.row
        cell.imageView?.sd_setImage(with: presenter.getImageURL(at: row), placeholderImage: UIImage.placeholder, options: .progressiveLoad, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter as? TVGPersonsListPresenter else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelect(index: indexPath.row)
    }
}

