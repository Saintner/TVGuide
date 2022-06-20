//
//  TVGShowDetailHeaderTableView.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import UIKit

class TVGShowDetailHeaderViewTableView: UIView {
    
    private var presenter: TVGShowDetailPresenter?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(with presenter:TVGShowDetailPresenter) {
        self.init()
        self.presenter = presenter
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI(){
        backgroundColor = .white
        setupPosterImage()
        setupNameLabel()
        setupAirsInformationLabel()
        setupGenreLabel()
        setupGenreInformationLabel()
    }
    
    private func setupPosterImage() {
        addSubview(posterImage)
        posterImage.sd_setImage(with: presenter?.getImageURL(), placeholderImage: UIImage.placeholder){ image,error,cache,url in
            self.posterImage.image = image?.scaleToViewSize(with: self.frame.size)
        }
        let topAnchor = NSLayoutConstraint(item: posterImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 0)
        let leftAnchor = NSLayoutConstraint(item: posterImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let rightAnchor = NSLayoutConstraint(item: posterImage, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: posterImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 500)
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor, height])
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.text = presenter?.getShowTitle()
        let topAnchor = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: posterImage, attribute: .bottom, multiplier: 1, constant: 40)
        let leftAnchor = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setupAirsInformationLabel() {
        addSubview(airsInformationLabel)
        airsInformationLabel.text = presenter?.getDaysAndTimeAired()
        let topAnchor = NSLayoutConstraint(item: airsInformationLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let leftAnchor = NSLayoutConstraint(item: airsInformationLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setupGenreLabel() {
        addSubview(genresTitleLabel)
        let topAnchor = NSLayoutConstraint(item: genresTitleLabel, attribute: .top, relatedBy: .equal, toItem: airsInformationLabel, attribute: .bottom, multiplier: 1, constant: 40)
        let leftAnchor = NSLayoutConstraint(item: genresTitleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    
    private func setupGenreInformationLabel() {
        addSubview(genresInformationLabel)
        let topAnchor = NSLayoutConstraint(item: genresInformationLabel, attribute: .top, relatedBy: .equal, toItem: genresTitleLabel, attribute: .bottom, multiplier: 1, constant: 40)
        let leftAnchor = NSLayoutConstraint(item: genresInformationLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([topAnchor, leftAnchor])
    }
    

}
