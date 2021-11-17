//
//  ProfileViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit

class ProfileViewController: UIViewController {

    init() {
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }
}
