//
//  DraggableCollectionViewModel.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import Foundation
import UIKit

protocol IDraggableCollectionViewModel: AnyObject {

    init(uiModel: IDraggableCollectionViewUIModel)
    
    var _innerSpacing : CGFloat { get }
    var _sideSpacing : CGFloat { get }
    var _itemWidthAndHeight : CGFloat { get }
    var _data : [DraggableCollectionViewItemModel] { get set }
    
}

class DraggableCollectionViewModel : IDraggableCollectionViewModel {
    
    // MARK: Injects
    private var uiModel: IDraggableCollectionViewUIModel
    
    required init(uiModel: IDraggableCollectionViewUIModel) {
        self.uiModel = uiModel
    }
    
    var _innerSpacing : CGFloat {
        return uiModel._innerSpacing
    }
    
    var _sideSpacing : CGFloat {
        return uiModel._sideSpacing
    }
    
    var _itemWidthAndHeight : CGFloat {
        return uiModel._itemWidthAndHeight
    }
    
    var _data : [DraggableCollectionViewItemModel] {
        get { return uiModel._data }
        set { uiModel.setDataList(data: newValue) }
    }
}
