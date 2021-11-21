//
//  HomeVc+Extension+CollectionDS.swift
//  StockApp
//
//  Created by Nalin Porwal on 21/11/21.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func configDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: {[weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else {return nil}
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockCell", for: indexPath) as? StockCell {
                cell.setUpData(itemIdentifier)
                if let wishlistManager = self.wishlistManager {
                    cell.isInWishList = wishlistManager.isStockInWisthList(with: itemIdentifier.id)
                }
                ///  ` Call Back`
                cell.wishlistCallBack = { [weak self] in
                    guard let inSelf = self else {return}
                    if inSelf.wishlistManager != nil {
                        inSelf.wishlistManager?.updateWishList(itemIdentifier.id)
                        if cell.isInWishList != nil {
                            cell.isInWishList?.toggle()
                        }
                    }
                }
                return cell
            } else {
                fatalError("Cell Not Fond ")
            }
        })
        snapShot = Snapshot()
        snapShot?.appendSections([1])
        snapShot?.appendItems([], toSection: 1)
        dataSource?.apply(snapShot ?? Snapshot(), animatingDifferences: true, completion: nil)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
