//
//  APIService.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 06/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation


class APIService{
    private let baseURL = "https://simple-contact-crud.herokuapp.com/"
    
    public func getAllContacts() -> [Contact]{
        return []
    }
    
    public func getContact(_ id : String) -> Contact{
        let contact = Contact()
        return contact
    }
    
    public func addNewContact(_ model : Contact) -> Bool {
        return false
    }
    
    public func editContact(_ model : Contact) -> Bool {
        return false
    }
    
    public func deleteContact(_ id : String) -> Bool{
        return false
    }
    
    
}
