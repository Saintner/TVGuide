//
//  TVGPersonDetailViewController+UITableViewDelegate.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

extension TVGPersonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
