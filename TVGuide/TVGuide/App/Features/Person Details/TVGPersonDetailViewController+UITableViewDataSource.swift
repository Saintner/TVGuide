//
//  TVGPersonDetailViewController+UITableViewDataSource.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

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
