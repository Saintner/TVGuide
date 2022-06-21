//
//  TVGPErsonsListViewController+UITableViewDelegate.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit


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
        if scrollView.didScrollToEnd {
               let presenter = presenter as! TVGPersonsListPresenter
                presenter.loadNewPage()
            }
    }
}
