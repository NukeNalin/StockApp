//
//  HomeViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit
import Combine
class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var wishlistManager: WishlistManager?
    lazy var stockViewModel: StockViewModel = .init()
    var stockListSubscriber: AnyCancellable?
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int,Stock>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int,Stock>
    
    var dataSource: DataSource?
    var snapShot: Snapshot?
    
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }

    convenience init(wishlistManager: WishlistManager) {
        self.init()
        self.wishlistManager = wishlistManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stockListSubscriber?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initailUIsetup()
        setUpSubscriber()
    }
    
    fileprivate func initailUIsetup() {
        title = "Home"
        let cellNib = UINib(nibName: "StockCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "StockCell")
        collectionView.collectionViewLayout = createLayout()
        configDataSource()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
    }
    
    fileprivate func setUpSubscriber() {
        stockListSubscriber = stockViewModel.$stockList.sink(receiveValue: { [weak self] stock in
            guard let self = self else {return}
            if self.snapShot == nil {return}
            self.snapShot?.deleteSections([1])
            self.snapShot?.appendSections([1])
            self.snapShot?.appendItems(stock, toSection: 1)

            self.dataSource?.apply(self.snapShot ?? Snapshot(), animatingDifferences: false, completion: nil)
        })
    }
    
    fileprivate func configDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: {[weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else {return nil}
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockCell", for: indexPath) as? StockCell {
                cell.setUpData(itemIdentifier)
                if let wishlistManager = self.wishlistManager {
                    cell.isInWishList = wishlistManager.isStockInWisthList(with: itemIdentifier.id)
                }
                cell.favCallBack = { [weak self] in
                    guard let self = self else {return}
                    if self.wishlistManager != nil {
                        self.wishlistManager?.updateWishList(itemIdentifier.id)
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
    
    fileprivate func createLayout() -> UICollectionViewCompositionalLayout {
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

extension HomeViewController: UICollectionViewDelegate {
}
