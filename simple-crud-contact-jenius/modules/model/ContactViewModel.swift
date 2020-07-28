//
//  ContactViewModel.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 27/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

class ContactViewModel {
    private let dataModel : Contact
    
    init(dataModel: Contact)
      {
          self.dataModel = dataModel
      }
    
    public var id : String {
        return dataModel.id ?? ""
    }
      
    public var firstName: String {
        return dataModel.firstName ?? ""
    }
    
    public var lastName: String {
        return dataModel.lastName ?? ""
    }
    public var name: String {
        return "Agent : \(dataModel.firstName ?? "") \(dataModel.lastName ?? "")"
    }
    
    public var age: String {
        return "\(dataModel.age ?? 0)"
    }
    
    public var photo : String{
        return dataModel.photo!
    }
    
    public var noPhoto : Bool {
        guard let photo = dataModel.photo else { return true }
        return photo == "N/A" ? true : false
    }
    
}
