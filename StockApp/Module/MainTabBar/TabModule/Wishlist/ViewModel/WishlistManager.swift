//
//  WishlistManager.swift
//  StockApp
//
//  Created by Nalin Porwal on 17/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
class WishlistManager {
    
    private var wishListStock = [String]()
    let db = Firestore.firestore()
    init() {
        GetWishListFromCloud()
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
         updateWishlistToCloud()
    }
    
    func updateWishlistToCloud() {
        guard let  userId = Auth.auth().currentUser?.uid  else {return}
        db.collection(userId).document("wishlist").setData([
            "value" : wishListStock
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func GetWishListFromCloud() {
        guard let  userId = Auth.auth().currentUser?.uid  else {return}
        db.collection(userId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.updateWishlistToCloud()
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    if let anyArray = document.data()["value"] as? [String] {
                        self.wishListStock = anyArray
                        print("======",self.wishListStock)
                    }
                }
            }
        }
    }
}
