//
//  DraggableCollectionViewController.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 25.01.2023.
//

import UIKit

class DraggableCollectionViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var collectionview: UICollectionView!
    
    // MARK: Injects
    private let viewModel : DraggableCollectionViewModel
    
    init(viewModel: DraggableCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCollectionView()
        setupDataSource()
    }

    // MARK: Props
    lazy var dataSource: DraggableCollectionViewCellDataSource = DraggableCollectionViewCellDataSource(collectionView: self.collectionview) { collectionview, indexPath, itemIdentifier in
        
        let cell = collectionview.dequeueReusableCell(forIndexPath: indexPath) as DraggableCollectionViewCell
        cell.configureCellWith(model: itemIdentifier)
        
        return cell
    }
}

extension DraggableCollectionViewController {
    private func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = viewModel._innerSpacing
        layout.minimumInteritemSpacing = viewModel._innerSpacing
        layout.sectionInset = UIEdgeInsets(top: viewModel._innerSpacing,
                                           left: viewModel._sideSpacing,
                                           bottom: viewModel._innerSpacing,
                                           right: viewModel._sideSpacing)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: viewModel._itemWidthAndHeight, height: viewModel._itemWidthAndHeight)
        
        self.collectionview.collectionViewLayout = layout
        self.collectionview.registerCell(type: DraggableCollectionViewCell.self)
        
        self.collectionview.dataSource = dataSource
        self.collectionview.delegate = dataSource
        
        // MARK: Drag & Drop delegatelerini dinleyebilmek icin delegateleri tanımlariz
        self.collectionview.dragDelegate = dataSource
        self.collectionview.dropDelegate = dataSource
        self.collectionview.dragInteractionEnabled = true
    }
    
    private func setupDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<SingleSection, DraggableCollectionViewItemModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel._data, toSection: .main)
        self.dataSource.apply(snapshot)
        
        dataSource.outputDelegate = self
        dataSource.updateDataSource(items: viewModel._data)
    }
}

extension DraggableCollectionViewController : DraggableCollectionViewCellDataSourceOutputDelegate {
    func itemDropped() {
        print("Items List\n")
        for item in dataSource.getDataSourceItems() {
            print("UUID: \(item.uuid), Color:  \(item.color.accessibilityName)")
        }
    }
}

enum SingleSection {
    case main
}
