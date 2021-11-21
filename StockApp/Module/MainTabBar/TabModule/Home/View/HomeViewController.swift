//
//  HomeViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit
import Combine
class HomeViewController: BaseViewController {

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
        collectionView.allowsMultipleSelection = true
    }
    
    fileprivate func setUpSubscriber() {
        self.showActivityIndicator()
        stockListSubscriber = stockViewModel.$stockList.sink(receiveValue: { [weak self] stock in
            guard let self = self else {return}
            if !stock.isEmpty {
                self.hideActivityIndicator()
            }
            if self.snapShot == nil {return}
            self.snapShot?.deleteSections([1])
            self.snapShot?.appendSections([1])
            self.snapShot?.appendItems(stock, toSection: 1)
            self.dataSource?.apply(self.snapShot ?? Snapshot(), animatingDifferences: false, completion: nil)
        })
    }

}
