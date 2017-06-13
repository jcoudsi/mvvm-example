//
//  ClientViewModelTests.swift
//  mvvm-exampleTests
//
//  Created by COUDSI Julien on 13/06/2017.
//  Copyright © 2017 Blop. All rights reserved.
//

import XCTest
import RxSwift

@testable import mvvm_example

class ClientViewModelTests: XCTestCase {
    
    func testClientViewModel() {
        
        let clientViewModel = ClientViewModel(api: FakeAPI.sharedInstance)
        
        XCTAssert(clientViewModel.birthdateText.value == "10/07/1985")
        XCTAssert(clientViewModel.completeNameText.value == "Jean-Michel Démo")
        XCTAssert(clientViewModel.firstNameText.value == "Jean-Michel")
        XCTAssert(clientViewModel.lastNameText.value == "Démo")
        XCTAssert(clientViewModel.jobText.value == "Expert COBOL")
        XCTAssert(clientViewModel.photoURL?.absoluteString == "http://pexou.synology.me/web_images/avatar1.jpg")
        
    }
    
    
}
