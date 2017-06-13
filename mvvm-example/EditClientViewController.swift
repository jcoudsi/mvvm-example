//
//  EditClientViewController.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import UIKit
import RxSwift

class EditClientViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    
    var clientViewModel:ClientViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clientViewModel = self.clientViewModel else {
            return
        }
        
        //ViewModel -> UITextField
        clientViewModel.firstNameText.asObservable().bind(to: self.firstNameTextField.rx.text).addDisposableTo(self.disposeBag)
        clientViewModel.lastNameText.asObservable().bind(to: self.lastNameTextField.rx.text).addDisposableTo(self.disposeBag)
        clientViewModel.birthdateText.asObservable().bind(to: self.birthdateTextField.rx.text).addDisposableTo(self.disposeBag)
        clientViewModel.jobText.asObservable().bind(to: self.jobTextField.rx.text).addDisposableTo(self.disposeBag)
        
        //UITextField -> ViewModel
        self.firstNameTextField.rx.text.bind(to: clientViewModel.firstNameText).addDisposableTo(self.disposeBag)
        self.lastNameTextField.rx.text.bind(to: clientViewModel.lastNameText).addDisposableTo(self.disposeBag)
        
        self.birthdateTextField.rx.text.filter {value in
            let dateComponents = value?.split(separator: "/")
            return dateComponents?.count == 3 && value?.count == 10
        }.bind(to:clientViewModel.birthdateText).addDisposableTo(self.disposeBag)
        
        self.jobTextField.rx.text.bind(to: clientViewModel.jobText).addDisposableTo(self.disposeBag)
    }
    
}
