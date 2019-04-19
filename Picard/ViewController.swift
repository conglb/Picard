//
//  ViewController.swift
//  Picard
//
//  Created by conglb on 4/10/19.
//  Copyright © 2019 conglb. All rights reserved.
//

import UIKit
import AWSAppSync

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK:
    //var appSyncClient: AWSAppSyncClient?

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appSyncClient = appDelegate.appSyncClient
        // Handle the text field’s user input through delegate callbacks.
        usernameTextField.delegate = self
    }
    
    
    /*
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
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginLabel.text =  usernameTextField.text
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromLibrary(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
        
    }
}

