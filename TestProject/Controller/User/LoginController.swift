//
//  LoginController.swift
//  TestProject
//
//  Created by Morten on 08/05/2024.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var userManager = UserManager()
    
    var login: String?
    var password: String?
    var deletable = false
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.text = login ?? ""
        passwordField.text = password ?? ""
        userManager.delegate = self
        print(Locale.current.languageCode)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        guard let login = loginField.text else { return  }
        guard let password = passwordField.text else { return  }
        UserDefaults.standard.set(
            login,
            forKey: DefaultsKeys.login
        )
        userManager.perfromRequest(user: NewUserRequest(username: login, password: password))
//        self.performSegue(withIdentifier: "goToMainMenu", sender: self)
    }
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToRegisterPage", sender: self)
    }

}

extension LoginController: UserManagerDelegate{
    func didUpdateUsers(_ userManager: UserManager, users: [User]) {
        return
    }
    
    func didVerifiedUser(_ userManager: UserManager, users: UserInfoDto) {
        print("delivered")
        DispatchQueue.main.async {
            if(users.userState == UserState.ACCESS){
                let defaults = UserDefaults.standard
                defaults.set(
                    users.id,
                    forKey: DefaultsKeys.userId
                )
//                defaults.set(
//                    users.role,
//                    forKey: DefaultsKeys.role
//                )
                self.performSegue(withIdentifier: "goToMainMenu", sender: self)
            }
        }
    }
    
    
}
