//
//  LoginViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func actionLogin(_ sender: Any) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate
         else {
           return
         }
         let viewcontroller = MainTabBarController()
         viewcontroller.view.backgroundColor = .blue
         sceneDelegate.window?.rootViewController = viewcontroller
    }
}
