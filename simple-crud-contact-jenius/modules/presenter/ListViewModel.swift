//
//  ListViewPresenter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 18/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa


class ListContactViewModel{
    var contacts = BehaviorRelay<[Contact]>(value: [])
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    
    func getAllContacts(){
        var contacts : [Contact] = []
        Alamofire.request(self.baseURL + "/contact", method: .get).responseJSON { (response) in
            
            if (response.response?.statusCode == 200){
                // fetch and convert the response into JSON
                let resultJSON : JSON = JSON(response.result.value!)
                guard let listDataJSON = resultJSON["data"].array else{
                    return
                }
                for data in listDataJSON {
                    let contact = Contact()
                    contact.firstName = data["firstName"].stringValue
                    contact.lastName = data["lastName"].stringValue
                    contact.id = data["id"].stringValue
                    contact.age = data["age"].stringValue
                    contact.photo = data["photo"].stringValue
                    contacts.append(contact)
                }
                self.contacts.accept(contacts)
//                self.view?.updateUI(contacts)
            }else{
//                self.view?.showError()
            }
        }
    }
}
