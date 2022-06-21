//
//  TVGPersonDetailViewController.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

class TVGPersonDetailViewController: UIViewController, TVGView {
    
    var presenter: TVGPresenter?
    
    private var posterImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.placeholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emptyShowsLabel: UILabel = {
        let label = UILabel()
        label.text = TVGConstants.emptyPersonShows
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: TVGConstants.defaultCellReuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let presenter = presenter as! TVGPersonDetailPresenter
        self.navigationItem.title = presenter.getPersonTitle()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        setupPosterImage()
        setupNameLabel()
        setTableView()
    }
    
    private func setupPosterImage() {
        view.addSubview(posterImage)
        let presenter = presenter as! TVGPersonDetailPresenter
        posterImage.sd_setImage(with: presenter.getImageURL(), placeholderImage: UIImage.placeholder){ image,error,cache,url in
            self.posterImage.image = image?.scaleToViewSize(with: self.view.frame.size)
        }
        let topAnchor = NSLayoutConstraint(item: posterImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: posterImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: posterImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: posterImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0, constant: 400)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, height])
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        let presenter = presenter as! TVGPersonDetailPresenter
        nameLabel.text = presenter.getPersonTitle()
        let topAnchor = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: posterImage, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        let topAnchor = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let leftAnchor = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let bottomAnchor = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, bottomAnchor])
    }
    
    
    private func setupEmptyShowsLabel() {
        view.addSubview(emptyShowsLabel)
        let topAnchor = NSLayoutConstraint(item: emptyShowsLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: emptyShowsLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: emptyShowsLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }

}


extension TVGPersonDetailViewController: TVGPersonDetailPresenterDelegate {
    func reloadTableView() {
        let presenter = presenter as! TVGPersonDetailPresenter
        if presenter.getShowsCount() == 0 {
            setupEmptyShowsLabel()
        }else {
            self.tableView.reloadData()
        }
    }
}
