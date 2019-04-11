//
//  ViewController.swift
//  Picard
//
//  Created by conglb on 4/10/19.
//  Copyright © 2019 conglb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    // MARK:
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        usernameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginLabel.text = "Hello " + usernameTextField.text + '!'
    }


    @IBAction func loginButton(_ sender: Any) {
        usernameTextField.text = "again"
        passwordTextField.text = "again"
    }
}

