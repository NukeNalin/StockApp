//
//  ProfileViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 15/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    init() {
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        labelName.text = Auth.auth().currentUser?.displayName ?? "not available"
    }
    @IBAction func actionLogout(_ sender: Any) {
        do {
        try Auth.auth().signOut()
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
                return
            }
            let viewcontroller = LoginViewController()
            viewcontroller.view.backgroundColor = .blue
            sceneDelegate.window?.rootViewController = viewcontroller
        } catch {
            print(error.localizedDescription)
        }
    }
}
