//
//  DraggableCollectionViewCell.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import UIKit

class DraggableCollectionViewCell: UICollectionViewCell, Reuseable {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellWith(model: DraggableCollectionViewItemModel) {
        self.contentView.backgroundColor = model.color
        
        self.setDefaultShadow()
    }
}
