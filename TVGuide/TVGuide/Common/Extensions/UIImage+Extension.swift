//
//  UIImage+Extension.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import UIKit

extension UIImage {
    static var placeholder: UIImage? {
        let image = UIImage(named: "placeholder-image")
        return image?.scaleToCellSize()
    }
    
    func scaleToCellSize() -> UIImage {
            let scaledImageSize = CGSize(
                width: 70,
                height: 100
            )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func scaleToViewSize(with viewSize: CGSize) -> UIImage {
            let scaledImageSize = CGSize(
                width: viewSize.width,
                height: 100
            )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
