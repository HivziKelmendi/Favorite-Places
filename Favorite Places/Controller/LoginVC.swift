//
//  LoginVC.swift
//  Favorite Places
//
//  Created by Hivzi on 16.8.22.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let persistence = PersistenceManager()
//        persistence.DeleteData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error)
                } else {
                    self.performSegue(withIdentifier: "LoginToMap", sender: self)
                }
            }
        }
    }
    
}
