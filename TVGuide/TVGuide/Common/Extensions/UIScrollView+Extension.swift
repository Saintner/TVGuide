//
//  UIScrollView+Extension.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import UIKit

extension UIScrollView {
    var didScrollToEnd: Bool {
            let height = frame.size.height
            let contentYoffset = contentOffset.y
            let distanceFromBottom = contentSize.height - contentYoffset
        return distanceFromBottom < height
    }
}
