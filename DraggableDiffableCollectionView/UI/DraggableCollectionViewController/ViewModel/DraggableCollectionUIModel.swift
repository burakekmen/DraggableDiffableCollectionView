//
//  DraggableCollectionViewUIModel.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import Foundation
import UIKit

protocol IDraggableCollectionViewUIModel {
    
    init()
    
    var _innerSpacing : CGFloat { get }
    var _sideSpacing : CGFloat { get }
    var _itemWidthAndHeight : CGFloat { get }
    var _data : [DraggableCollectionViewItemModel] { get }
    
    mutating func setDataList(data: [DraggableCollectionViewItemModel])
}

struct DraggableCollectionUIModel: IDraggableCollectionViewUIModel {
    
    // MARK: Private Props
    private static let innerSpacing: CGFloat = 5.0
    private static let sideSpacing: CGFloat = 5.0
    private static let itemWidthAndHeight = (UIScreen.main.bounds.width - 20 - (sideSpacing * 2) - ( innerSpacing * 2)) / 3
    
    private var data: [DraggableCollectionViewItemModel] = [
        DraggableCollectionViewItemModel(color: .blue),
        DraggableCollectionViewItemModel(color: .brown),
        DraggableCollectionViewItemModel(color: .green),
        DraggableCollectionViewItemModel(color: .yellow),
        DraggableCollectionViewItemModel(color: .red),
        DraggableCollectionViewItemModel(color: .magenta),
        DraggableCollectionViewItemModel(color: .purple),
        DraggableCollectionViewItemModel(color: .orange)
    ]
    
    init() {
    }
    
    // MARK: Public Props
    var _innerSpacing : CGFloat {
        return DraggableCollectionUIModel.innerSpacing
    }
    
    var _sideSpacing : CGFloat {
        return DraggableCollectionUIModel.sideSpacing
    }
    
    var _itemWidthAndHeight : CGFloat {
        return DraggableCollectionUIModel.itemWidthAndHeight
    }
    
    var _data : [DraggableCollectionViewItemModel] {
        return data
    }
}


extension DraggableCollectionUIModel {
    mutating func setDataList(data: [DraggableCollectionViewItemModel]) {
        self.data = data
    }
}
