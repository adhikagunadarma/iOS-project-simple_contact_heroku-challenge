//
//  ContactInteractor.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire

class ListContactInteractor : PresenterToInteractorListProtocol {
    var presenter : InteractorToPresenterListProtocol?
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    func getContacts(){
        print("123")
        var contacts : [DetailContact] = []
        Alamofire.request(self.baseURL + "/contact", method: .get).responseJSON { (response) in
            
            if (response.response?.statusCode == 200){
                // fetch and convert the response into JSON
                let resultJSON : JSON = JSON(response.result.value!)
                guard let listDataJSON = resultJSON["data"].array else{
                    return
                }
                
                for data in listDataJSON {
                    let contact = DetailContact()
                    contact.firstName = data["firstName"].stringValue
                    contact.lastName = data["lastName"].stringValue
                    contact.id = data["id"].stringValue
                    contact.age = data["age"].stringValue
                    contact.photo = data["photo"].stringValue
                    contacts.append(contact)
                }
                self.presenter?.listContactFetchSuccess(contacts)
            }else{
                self.presenter?.listContactFetchFailed()
            }
        }
    }
    
 
    
}
