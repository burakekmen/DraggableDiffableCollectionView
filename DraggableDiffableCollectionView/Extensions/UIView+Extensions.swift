//
//  UIView+Extensions.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import Foundation
import UIKit

extension UIView {
    func nibName() -> String {
       return type(of: self).description().components(separatedBy: ".").last!
    }
    
    func setDefaultShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
}
