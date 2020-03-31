//
//  LogInViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/14/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var visibilityButton: UIButton!
    @IBOutlet weak var messageError: UIView!
    
    var usernameText = ""
    var passwordText = ""
    var passwordVisibility = false
    var delegate: ModalHandler? = nil
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = message
        logInButton.isEnabled = false
        logInButton.alpha = 0.5
        visibilityButton.isHidden = true
        messageError.layer.cornerRadius = 4
    }

    @IBAction func onPressLogin(_ sender: Any) {
        self.messageError.isHidden = true
        let validateLogin = { (success: Bool) in
            SVProgressHUD.dismiss()
            if success {
                self.messageError.isHidden = true
                self.delegate?.modalDismissed()
                self.dismiss(animated: true, completion: nil)
            } else {
                self.messageError.isHidden = false
            }
        }
    
        SVProgressHUD.show()

        AccountManager.login(username: self.usernameInput.text ?? "", password: self.passwordInput.text ?? "", completion: validateLogin)
    }

    @IBAction func usernameFieldEditingChanged(_ sender: Any) {
        self.usernameText = usernameInput.text ?? ""
        validateTextInputs()
    }

    @IBAction func passwordFieldEditingChanged(_ sender: Any) {
        self.passwordText = passwordInput.text ?? ""
        validateTextInputs()
    }

    @IBAction func onCloseLogIn(_ sender: Any) {
        self.delegate?.modalDismissed()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTogglePasswordVisibility(_ sender: Any) {
        if(passwordVisibility) {
            passwordInput.isSecureTextEntry = false
        } else {
            passwordInput.isSecureTextEntry = true
        }
        passwordVisibility = !passwordVisibility
    }

    func validateTextInputs() {
        if (passwordText != "") {
            visibilityButton.isHidden = false
            if(usernameText != "") {
                logInButton.isEnabled = true
                logInButton.alpha = 1
            }
        } else {
            visibilityButton.isHidden = true
            logInButton.isEnabled = false
            logInButton.alpha = 0.5
        }
    }
    
}
