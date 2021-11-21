//
//  SignUpViewController.swift
//  StockApp
//
//  Created by Nalin Porwal on 18/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var textFiledPassowrd: UITextField!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textFiledEmail: UITextField!
    
    init() {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    func initialSetUp() {
        textfieldName.setCornerRadius()
        textFiledEmail.setCornerRadius()
        textFiledPassowrd.setCornerRadius()
        btnSignUp.setCornerRadius()
    }
    
    @IBAction func actionCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        guard let name = textfieldName.text else {return}
        guard let email = textFiledEmail.text else {return}
        guard let password = textFiledPassowrd.text else {return}
        if name.isEmpty {
            self.showAlert("Please Enter Your Name", title: "")
            return
        }
        showActivityIndicator()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else {return}
            self.hideActivityIndicator()
            if error == nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { error in    }
                self.showAlert("Alert", title: "Account is created Successfully") {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.showAlert(error!.localizedDescription , title: "Error")
            }
        }
    }
}
