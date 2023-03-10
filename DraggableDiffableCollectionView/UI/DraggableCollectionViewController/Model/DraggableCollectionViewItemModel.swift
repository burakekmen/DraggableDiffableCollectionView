//
//  DraggableCollectionViewItemModel.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import Foundation
import UIKit

struct DraggableCollectionViewItemModel : Hashable {
    let uuid: String = UUID().uuidString
    let color: UIColor
}
