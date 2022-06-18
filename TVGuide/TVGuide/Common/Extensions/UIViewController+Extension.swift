//
//  UIViewController+Extension.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import UIKit

extension UINavigationController {
    convenience init(withRootController rootViewController: UIViewController? ) {
        guard let root = rootViewController else {
            self.init(rootViewController: UIViewController())
            return
        }
        self.init(rootViewController: root)
    }
}
