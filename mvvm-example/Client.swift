//
//  Client.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import UIKit

class Client {
    
    var firstName:String
    var lastName:String
    var birthdate:Date
    var job:String
    var photoUrl:String?
    
    init (firstName:String, lastName:String, birthdate:Date, job:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.job = job
    }
}
