//
//  EditClientViewController.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import UIKit

protocol EditClientViewControllerDelegate {
    func editClientViewController(editClientViewController:EditClientViewController, shouldUpdateWithClient client:Client)
}

class EditClientViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    
    var client:Client!
    var delegate:EditClientViewControllerDelegate?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.firstNameTextField.text = self.client.firstName
        self.lastNameTextField.text = self.client.lastName
        self.birthdateTextField.text = self.dateFormatter.string(from: self.client.birthdate)
        self.jobTextField.text = self.client.job
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.birthdateTextField.delegate = self
        self.jobTextField.delegate = self
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.firstNameTextField, let value = textField.text {
            self.client.firstName = value
        } else if textField == self.lastNameTextField, let value = textField.text {
            self.client.lastName = value
        } else if textField == self.birthdateTextField, let value = textField.text, value.count == 10, let date = dateFormatter.date(from:value) {
            self.client.birthdate = date
        } else if textField == self.jobTextField, let value = textField.text {
            self.client.job = value
        }
        
        self.delegate?.editClientViewController(editClientViewController: self, shouldUpdateWithClient: self.client)
    }
    
    
}
