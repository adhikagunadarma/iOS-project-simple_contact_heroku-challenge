//
//  simple_crud_contact_jeniusTests.swift
//  simple-crud-contact-jeniusTests
//
//  Created by Josephine Fransisca on 28/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import XCTest
@testable import simple_crud_contact_jenius

class simple_crud_contact_jeniusTests: XCTestCase {
   
    func testContactViewModelWithPhoto(){
        let contact = Contact(id: "1", firstName: "Adhika", lastName: "Gunadarma", age: 24, photo: "N/A")
        let contactViewModel = ContactViewModel(dataModel: contact)
        XCTAssertEqual(contact.firstName, contactViewModel.firstName)
        XCTAssertEqual(contact.lastName, contactViewModel.lastName)
        XCTAssertEqual("Agent : \(contact.firstName!) \(contact.lastName!)" , contactViewModel.name)
        XCTAssertEqual(contact.age, Int(contactViewModel.age))
        XCTAssertEqual(contact.id, contactViewModel.id)
        XCTAssertEqual(contact.photo, contactViewModel.photo)
        XCTAssertEqual(true, contactViewModel.noPhoto)
        
    }
    
    func testContactViewModelWithoutPhoto(){
        let contact = Contact(id: "1", firstName: "Adhika", lastName: "Gunadarma", age: 24, photo: "www.google.com")
        let contactViewModel = ContactViewModel(dataModel: contact)
        XCTAssertEqual(contact.firstName, contactViewModel.firstName)
        XCTAssertEqual(contact.lastName, contactViewModel.lastName)
        XCTAssertEqual("Agent : \(contact.firstName!) \(contact.lastName!)" , contactViewModel.name)
        XCTAssertEqual(contact.age, Int(contactViewModel.age))
        XCTAssertEqual(contact.id, contactViewModel.id)
        XCTAssertEqual(contact.photo, contactViewModel.photo)
        XCTAssertEqual(false, contactViewModel.noPhoto)
        
    }
    
    func testPresentAlert(){
        let messageText = "Test Present Alert"
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        XCTAssertEqual(Utils.presentAlert(messageText).title, alert.title)
        XCTAssertEqual(Utils.presentAlert(messageText).message, alert.message)
        
        XCTAssertEqual(Utils.presentAlert(messageText).actions.map({
            $0.title
        }), alert.actions.map({
            $0.title
        }))
        XCTAssertEqual(Utils.presentAlert(messageText).actions.map({
            $0.style
        }), alert.actions.map({
            $0.style
        }))
        
    }
}
