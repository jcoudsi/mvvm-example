//
//  ClientViewModel.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 13/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import Foundation
import RxSwift

class ClientViewModel {
    
    private let disposeBag = DisposeBag()
    private var client:Client
    
    var firstNameText:Variable<String?>
    var lastNameText:Variable<String?>
    var completeNameText:Variable<String?>
    var birthdateText:Variable<String?>
    var jobText:Variable<String?>
    var photoURL:URL?
    
    init(api:FakeAPI) {
        
        self.client = api.getClient()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        //Model -> ViewModel
        
        self.firstNameText = Variable<String?>(client.firstName)
        self.lastNameText = Variable<String?>(client.lastName)
        self.completeNameText = Variable<String?>("\(client.firstName) \(client.lastName)")
        
        self.birthdateText = Variable<String?>(dateFormatter.string(from: client.birthdate))
        self.jobText = Variable<String?>(client.job)
        
        if let photoUrlString = client.photoUrl, let photoUrl = URL(string:photoUrlString) {
            self.photoURL = photoUrl
        }
        
        //ViewModel -> Model
        
        self.firstNameText.asObservable().subscribe(onNext: { [weak self] firstNameText in
            self?.client.firstName = firstNameText ?? ""
        }).addDisposableTo(self.disposeBag)
        
        self.lastNameText.asObservable().subscribe(onNext: { [weak self] lastNameText in
            self?.client.lastName = lastNameText ?? ""
        }).addDisposableTo(self.disposeBag)
        
        self.jobText.asObservable().subscribe(onNext: { [weak self] jobText in
            self?.client.job = jobText ?? ""
        }).addDisposableTo(self.disposeBag)
        
        self.birthdateText.asObservable().subscribe(onNext: { [weak self] birthdateText in
           self?.client.birthdate = dateFormatter.date(from: birthdateText!)!
        }).addDisposableTo(self.disposeBag)
        
        self.jobText.asObservable().subscribe(onNext: { [weak self] jobText in
            self?.client.job = jobText ?? ""
        }).addDisposableTo(self.disposeBag)
        
        //ViewModel -> ViewModel
        
        Observable.combineLatest([self.firstNameText.asObservable(), self.lastNameText.asObservable()]) { nameInfo  in
            return "\(nameInfo[0] ?? "") \(nameInfo[1] ?? "")"
        }.bind(to: self.completeNameText).addDisposableTo(self.disposeBag)
        
    }
    
}
