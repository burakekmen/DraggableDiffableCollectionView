//
//  DraggableCollectionViewBuilder.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import UIKit

enum DraggableCollectionViewBuilder {
    static func generate() -> DraggableCollectionViewController {
        let uiModel = DraggableCollectionUIModel()
        let viewModel = DraggableCollectionViewModel(uiModel: uiModel)
        
        return DraggableCollectionViewController(viewModel: viewModel)
    }
}
