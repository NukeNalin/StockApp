//
//  MainTabBarController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    var stockViewModel = StockViewModel()
    lazy var wishListManager = WishlistManager()
    
    init() {
        super.init(nibName: "MainTabBarController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    func initialSetUp() {
        
        /// SetUp Icon
        let icon1 = UITabBarItem(title: "Title", image: UIImage(systemName: "circle"), selectedImage:  UIImage(systemName: "circle"))
        let icon2 = UITabBarItem(title: "Title2", image: UIImage(systemName: "circle"), selectedImage:  UIImage(systemName: "circle"))
        let icon3 = UITabBarItem(title: "Title3", image: UIImage(systemName: "circle"), selectedImage:  UIImage(systemName: "circle"))
        
        /// Setup ViewContoller
        let homeNavigation = UINavigationController(rootViewController: HomeViewController(wishlistManager: wishListManager))
        let wishlistNavigation = UINavigationController(rootViewController: WishListViewController(wishlistManager: wishListManager))
        let profileNavigation = UINavigationController(rootViewController: ProfileViewController())
        
        let children :[(UIViewController,UITabBarItem)] = [(homeNavigation,icon1),
                          (wishlistNavigation,icon2),
                          (profileNavigation,icon3)]
        
        for child in children {
            child.0.tabBarItem = child.1
            if let navVc = child.0 as? UINavigationController {
                navVc.navigationBar.prefersLargeTitles = true
                navVc.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.highLightColor]
                navVc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.highLightColor]
                navVc.navigationBar.barTintColor = UIColor.background
            }
            addChild(child.0)
        }
    }
}

