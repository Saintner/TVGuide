//
//  TVGShowDetailViewController+UITableViewDataSource.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

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
        guard let presenter = presenter as? TVGShowDetailPresenter else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        let section = indexPath.section
        let row = indexPath.row
        presenter.didSelectEpisode(for: section, at: row)
    }
}
