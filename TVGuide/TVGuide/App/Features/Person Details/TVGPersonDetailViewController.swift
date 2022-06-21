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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TVGPersonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension TVGPersonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let presenter = presenter as! TVGPersonDetailPresenter
        return presenter.getShowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVGConstants.defaultCellReuseIdentifier, for: indexPath)
        let presenter = presenter as! TVGPersonDetailPresenter
        let row = indexPath.row
        cell.textLabel!.text = presenter.getShowName(at: row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter as? TVGPersonDetailPresenter else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        let row = indexPath.row
        presenter.didSelectShow(at: row)
    }
    
    
}

extension TVGPersonDetailViewController: TVGPersonDetailPresenterDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
