//
//  Contact.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 06/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

struct ListContact: Codable {
    let message : String
    let data: [Contact]
}

struct DetailContact: Codable {
    let message : String
    let data: Contact
}

struct Contact  : Codable{
    var id : String?
    var firstName : String?
    var lastName : String?
    var age : Int?
    var photo : String?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case age
        case photo
        case id
    }
    
//    init(from decoder: Decoder) throws {
//
//        let map = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try map.decode(String?.self, forKey: .id)
//        firstName = try map.decode(String?.self, forKey: .firstName)
//        photo = try map.decode(String?.self, forKey: .photo)
//        lastName = try map.decode(String?.self, forKey: .lastName)
//        age = try map.decode(String?.self, forKey: .age)
//    }
}

