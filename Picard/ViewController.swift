//
//  ViewController.swift
//  Picard
//
//  Created by conglb on 4/10/19.
//  Copyright © 2019 conglb. All rights reserved.
//

import UIKit
import AWSMobileClient

class ViewController: UIViewController, UITextFieldDelegate {

    
    // MARK:
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeAWSMobileClient()
        // Handle the text field’s user input through delegate callbacks.
        usernameTextField.delegate = self
    }
    
    // Use the iOS SDK drop-in Auth UI to show login options to user (Basic auth, Google, or Facebook)
    // Note: The view controller implementing the drpo-in auth UI needs to be associated with a Navigation Controller.
    func showSignIn() {
        AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, {
            (userState, error) in
            if(error == nil){   // Successful signin
                DispatchQueue.main.async {
                    print("User successfully logged in")
                }
            }
        })
    }
    
    // Initializing the AWSMobileClient and take action based on current user state
    func initializeAWSMobileClient() {
        AWSMobileClient.sharedInstance().initialize { (userState, error) in
            
            //self.addUserStateListener() // Register for user state changes
            
            if let userState = userState {
                switch(userState){
                case .signedIn: // is Signed IN
                    print("Logged In")
                    print("Cognito Identity Id (authenticated): \(AWSMobileClient.sharedInstance().identityId))")
                case .signedOut: // is Signed OUT
                    print("Logged Out")
                    DispatchQueue.main.async {
                        self.showSignIn()
                    }
                case .signedOutUserPoolsTokenInvalid: // User Pools refresh token INVALID
                    print("User Pools refresh token is invalid or expired.")
                    DispatchQueue.main.async {
                        self.showSignIn()
                    }
                case .signedOutFederatedTokensInvalid: // Facebook or Google refresh token INVALID
                    print("Federated refresh token is invalid or expired.")
                    DispatchQueue.main.async {
                        self.showSignIn()
                    }
                default:
                    AWSMobileClient.sharedInstance().signOut()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginLabel.text =  usernameTextField.text
    }


    @IBAction func loginButton(_ sender: Any) {
        usernameTextField.text = "again"
        passwordTextField.text = "again"
    }
}

