//
//  TVGShowDetailViewController.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import UIKit

class TVGShowDetailViewController: UIViewController, TVGView {
    
    var presenter: TVGPresenter?
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private var airsInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genresTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Genres"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genresInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var summaryTextView: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
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
        let presenter = presenter as! TVGShowDetailPresenter
        presenter.viewDidLoad()
        
        self.navigationItem.title = presenter.getShowTitle()
        setScrollView()
    }
    
    func setScrollView(){
        view.addSubview(scrollView)
        let topAnchor = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let bottomAnchor = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, bottomAnchor])
        scrollView.addSubview(contentView)
        let topContentViewAnchor = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
        let leftContentViewAnchor = NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0)
        let rightContentViewAnchor = NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 0, constant: 1800)
        let bottomContentViewAnchor = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topContentViewAnchor, leftContentViewAnchor, rightContentViewAnchor, bottomContentViewAnchor, height, width])
        setupUI()
    }
    
    private func setupUI(){
        setupPosterImage()
        setupNameLabel()
        setupAirsInformationLabel()
        setupGenreLabel()
        setupGenreInformationLabel()
        setSummaryLabel()
        setTableView()
    }
    
    private func setupPosterImage() {
        contentView.addSubview(posterImage)
        let presenter = presenter as! TVGShowDetailPresenter
        posterImage.sd_setImage(with: presenter.getImageURL(), placeholderImage: UIImage.placeholder){ image,error,cache,url in
            self.posterImage.image = image?.scaleToViewSize(with: self.view.frame.size)
        }
        let topAnchor = NSLayoutConstraint(item: posterImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: posterImage, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: posterImage, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: posterImage, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0, constant: 500)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, height])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        let presenter = presenter as! TVGShowDetailPresenter
        nameLabel.text = presenter.getShowTitle()
        let topAnchor = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: posterImage, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }
    
    private func setupAirsInformationLabel() {
        contentView.addSubview(airsInformationLabel)
        let presenter = presenter as! TVGShowDetailPresenter
        airsInformationLabel.text = presenter.getDaysAndTimeAired()
        let topAnchor = NSLayoutConstraint(item: airsInformationLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let leftAnchor = NSLayoutConstraint(item: airsInformationLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setupGenreLabel() {
        contentView.addSubview(genresTitleLabel)
        let topAnchor = NSLayoutConstraint(item: genresTitleLabel, attribute: .top, relatedBy: .equal, toItem: airsInformationLabel, attribute: .bottom, multiplier: 1, constant: 30)
        let leftAnchor = NSLayoutConstraint(item: genresTitleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setupGenreInformationLabel() {
        contentView.addSubview(genresInformationLabel)
        let presenter = presenter as! TVGShowDetailPresenter
        genresInformationLabel.text = presenter.getGenres()
        let topAnchor = NSLayoutConstraint(item: genresInformationLabel, attribute: .top, relatedBy: .equal, toItem: genresTitleLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let leftAnchor = NSLayoutConstraint(item: genresInformationLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setSummaryLabel() {
        contentView.addSubview(summaryTextView)
        let presenter = presenter as! TVGShowDetailPresenter
        summaryTextView.attributedText = presenter.getSummaryTitle()?.htmlToAttributedString
        let topAnchor = NSLayoutConstraint(item: summaryTextView, attribute: .top, relatedBy: .equal, toItem: genresInformationLabel, attribute: .bottom, multiplier: 1, constant: 30)
        let leftAnchor = NSLayoutConstraint(item: summaryTextView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: summaryTextView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -16)
        let height = NSLayoutConstraint(item: summaryTextView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0, constant: 150)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right, height])
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(tableView)
        let topAnchor = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: summaryTextView, attribute: .bottom, multiplier: 1, constant: 20)
        let leftAnchor = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let bottomAnchor = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, bottomAnchor])
    }
    
    override func viewDidLayoutSubviews() {
        print(tableView.contentSize)
    }
}


extension TVGShowDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let presenter = presenter as! TVGShowDetailPresenter
        return presenter.getSeasonNumber(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension TVGShowDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter as? TVGShowDetailPresenter else { return 0 }
        return presenter.getEpisodesCount(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let presenter = presenter as? TVGShowDetailPresenter else { return 0 }
        return presenter.getSeasonsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVGConstants.defaultCellReuseIdentifier, for: indexPath)
        guard let presenter = presenter as? TVGShowDetailPresenter else { return cell }
        let section = indexPath.section
        let row = indexPath.row
        cell.textLabel!.text =  presenter.getEpisodeTitle(for: section, at: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter as? TVGShowsListPresenter else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelect(index: indexPath.row)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
