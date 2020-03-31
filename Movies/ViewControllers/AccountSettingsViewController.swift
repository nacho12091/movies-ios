//
//  AccountSettingsViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/15/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ModalHandler {
    func modalDismissed()
}

class AccountSettingsViewController: UIViewController, ModalHandler {
    
    private struct keys {
        static let presentLogin = "presentLogin"
        static let mail = "@gmail.com"
    }

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    func modalDismissed() {
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        fetchUserData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? UINavigationController
        let loginViewController = controller?.viewControllers.first as! LogInViewController
        loginViewController.delegate = self
        loginViewController.message = Constants.messages.loginToAccessSettings
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !SessionManager.isLogged() {
            performSegue(withIdentifier: keys.presentLogin, sender: nil)
        } else {
            fetchUserData()
        }
    }
    
    @IBAction func onPressLogOut(_ sender: Any) {
        self.userName.text = ""
        self.userEmail.text = ""
        SessionManager.clearSession()
        tabBarController?.selectedIndex = 0
    }
    
    private func fetchUserData() {
        if SessionManager.isLogged() {
            let completion = { (fetchedData: Account) in
                self.userName.text = fetchedData.userName
                self.userEmail.text = fetchedData.userName + keys.mail
                SVProgressHUD.dismiss()
            }
            
            SVProgressHUD.show()
            AccountManager.getUserData(completion: completion)
        }
    }
    
}
