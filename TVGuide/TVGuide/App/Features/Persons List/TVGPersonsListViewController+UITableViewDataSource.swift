//
//  TVGPersonsListViewController+UITableViewDataSource.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

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

