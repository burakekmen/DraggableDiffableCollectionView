//
//  DraggableCollectionViewCellDataSource.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 28.01.2023.
//

import Foundation
import UIKit

protocol DraggableCollectionViewCellDataSourceOutputDelegate : AnyObject {
    func itemDropped()
}

final class DraggableCollectionViewCellDataSource: UICollectionViewDiffableDataSource<SingleSection, DraggableCollectionViewItemModel> {
    
    weak var outputDelegate: DraggableCollectionViewCellDataSourceOutputDelegate?
    
    private var items: [DraggableCollectionViewItemModel] = []
    
    func updateDataSource(items: [DraggableCollectionViewItemModel]) {
        self.items = items
    }
    
    func getDataSourceItems() -> [DraggableCollectionViewItemModel] {
        return items
    }
}

extension DraggableCollectionViewCellDataSource: UICollectionViewDelegate {
    
}


extension DraggableCollectionViewCellDataSource : UICollectionViewDragDelegate {
    // MARK: Drag yapilmak istenen cell item doner
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = items[indexPath.row]
        
        // MARK: ItemProvider olustururken objenizde uniq bir deger olmasi sarttir. Bu bilgi ile Drag islemi yapilmaktadir
        let itemProvider = NSItemProvider(object: item.uuid as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        dragItem.localObject = item
        return [dragItem]
    }
}

extension DraggableCollectionViewCellDataSource : UICollectionViewDropDelegate {
    
    // MARK: Cell drag yapıp diger celleri kaydirirken burası uzerinden bilgi alip cellerin hareket yapabilme bilgisini alır. Eger operation: forbidden olursa cell bulundugu konumdan baska noktaya hareket etmez
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            
//            MARK: Ilk cell hareket etmemesini saglamak icin bir ornek
//            if destinationIndexPath?.row == 0 {
//                return UICollectionViewDropProposal(operation: .forbidden)
//            } else {
//                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//            }
            
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    // MARK: Drop isleminin collectionView de uygulanmasini saglar. Coordinator'de Drag yapilan item ve Drop yapilan destination noktasini icerir
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        var destinationIndexPath : IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(row: row-1, section: 0)
        }
        
        // MARK: Drop yapmak istedigimiz noktanın operation enum degeri move ise listede reOrder islemi yaptiriyoruz
        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
}


extension DraggableCollectionViewCellDataSource {
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            
            var snapshot = snapshot()
            
            // MARK: Bu kontrol yapılarak listenin saglıklı sekilde drag-drop yapılması saglaniyor
            if sourceIndexPath.row < destinationIndexPath.row {
                // MARK: Tasinan cell indexi, bırakılmak istenen indexten onde ise (1->5)
                snapshot.moveItem(self.itemIdentifier(for: sourceIndexPath)!, afterItem: self.itemIdentifier(for: destinationIndexPath)!)
            } else {
                // MARK: Tasinan cell indexi, bırakılmak istenen indexten geride ise (7->2)
                snapshot.moveItem(self.itemIdentifier(for: sourceIndexPath)!, beforeItem: self.itemIdentifier(for: destinationIndexPath)!)
            }
            
            // MARK: Yapılan degisikligi snapshot icerisinde de uyugulayıp dataSource a veriyoruz. DataSource guncellemesi ile birlikte listenin degisen alanları collectionView icinde guncelleniyor.
            self.apply(snapshot, animatingDifferences: true)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            
            // MARK: Islem sonunda ViewController tarafina haber vermesi icin outputDelegate tetikleniyor
            let sourceItem = self.items.remove(at: sourceIndexPath.row)
            self.items.insert(sourceItem, at: destinationIndexPath.item)
            outputDelegate?.itemDropped()
        }
    }
}
