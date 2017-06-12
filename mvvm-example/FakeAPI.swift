//
//  FakeAPI.swift
//  mvvm-example
//
//  Created by COUDSI Julien on 12/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import Foundation

class FakeAPI {
    
    static let sharedInstance = FakeAPI()
    func getClient() -> Client {
        
        let client = Client(firstName: "Jean-Michel", lastName: "Démo", birthdate: Date.from(string: "10/07/1985")!, job: "Expert COBOL")
        client.photoUrl = URL(string: "http://pexou.synology.me/web_images/avatar1.jpg")
        
        return client
    }
}
