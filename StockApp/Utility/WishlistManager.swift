//
//  WishlistManager.swift
//  StockApp
//
//  Created by Nalin Porwal on 17/11/21.
//

import Foundation

class WishlistManager {
    
    private var wishListStock = [String]()
    
    init() {
       // GetWishListFromCloud
    }
    
    func getWishListStock() -> [String] {
        return wishListStock
    }
    
    func isStockInWisthList(with id: String) -> Bool {
        wishListStock.contains(id)
    }
     func updateWishList(_ stockID: String) {
        if wishListStock.contains(stockID) {
            wishListStock.removeAll { $0 == stockID }
        } else {
            wishListStock.append(stockID)
        }
    }
    
    func updateWishlistToCloud() {
    }
    
    func GetWishListFromCloud() {
    }
}
