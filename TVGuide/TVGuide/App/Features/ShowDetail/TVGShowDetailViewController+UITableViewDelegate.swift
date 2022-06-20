//
//  TVGShowDetailViewController+UITableViewDelegate.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import UIKit

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
