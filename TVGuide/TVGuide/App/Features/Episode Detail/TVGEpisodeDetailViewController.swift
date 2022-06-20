//
//  TVGEpisodeDetailViewController.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

class TVGEpisodeDetailViewController: UIViewController, TVGView {
    
    var presenter: TVGPresenter?
    
    private var episodeImage: UIImageView = {
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
    
    private var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var seasonLabel: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let presenter = presenter as! TVGEpisodeDetailPresenter
        view.backgroundColor = .white
        navigationItem.title = presenter.getEpisodeName()
        setUI()
    }
    
    private func setUI() {
        setupPosterImage()
        setupNameLabel()
        setupNumberLabel()
        setupSeasonLabel()
        setSummaryLabel()
    }
    
    private func setupPosterImage() {
        view.addSubview(episodeImage)
        let presenter = presenter as! TVGEpisodeDetailPresenter
        episodeImage.sd_setImage(with: presenter.getEpisodeImageURL(), placeholderImage: UIImage.placeholder){ image,error,cache,url in
            self.episodeImage.image = image?.scaleToViewSize(with: self.view.frame.size)
        }
        let topAnchor = NSLayoutConstraint(item: episodeImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: episodeImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: episodeImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: episodeImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0, constant: 300)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, height])
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        let presenter = presenter as! TVGEpisodeDetailPresenter
        nameLabel.text = presenter.getEpisodeName()
        let topAnchor = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: episodeImage, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }
    
    private func setupNumberLabel() {
        view.addSubview(numberLabel)
        let presenter = presenter as! TVGEpisodeDetailPresenter
        numberLabel.text = presenter.getEpisodeNumber()
        let topAnchor = NSLayoutConstraint(item: numberLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: numberLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: numberLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }
    
    private func setupSeasonLabel() {
        view.addSubview(seasonLabel)
        let presenter = presenter as! TVGEpisodeDetailPresenter
        seasonLabel.text = presenter.getEpisodeSeason()
        let topAnchor = NSLayoutConstraint(item: seasonLabel, attribute: .top, relatedBy: .equal, toItem: numberLabel, attribute: .bottom, multiplier: 1, constant: 25)
        let leftAnchor = NSLayoutConstraint(item: seasonLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: seasonLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right])
    }
    
    private func setSummaryLabel() {
        view.addSubview(summaryTextView)
        let presenter = presenter as! TVGEpisodeDetailPresenter
        summaryTextView.attributedText = presenter.getEpisodeSummary()?.htmlToAttributedString
        let topAnchor = NSLayoutConstraint(item: summaryTextView, attribute: .top, relatedBy: .equal, toItem: seasonLabel, attribute: .bottom, multiplier: 1, constant: 30)
        let leftAnchor = NSLayoutConstraint(item: summaryTextView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16)
        let right = NSLayoutConstraint(item: summaryTextView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16)
        let height = NSLayoutConstraint(item: summaryTextView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0, constant: 150)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, right, height])
    }

}
