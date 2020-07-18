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

protocol PresenterDetailView : class {
    func updateUI(_ contact : Contact)
    func showSuccess(_ message : String)
    func showError()
}

class DetailContactPresenter{
    weak var view: PresenterDetailView?
    
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    init(with view: PresenterDetailView) {
        self.view = view
    }
    
    private func toJSON(_ contact : Contact) -> JSON {
        // function to convert model into json because Alamofire only support json type of params
        return [
            "firstName": contact.firstName as Any,
            "lastName": contact.lastName as Any,
            "age": contact.age as Any,
            //            "photo": contact.photo as Any
            
        ]
    }
    
    func getContact(_ id : String){
        // api call function to get contact
        Alamofire.request(self.baseURL + "/contact/\(id)", method: .get).responseJSON { (response) in
            
            if (response.response?.statusCode == 200){
                // fetch and convert the response into JSON
                let resultJSON : JSON = JSON(response.result.value!)
                let contact = Contact()
                contact.firstName = resultJSON["data"]["firstName"].stringValue
                contact.lastName = resultJSON["data"]["lastName"].stringValue
                contact.id = resultJSON["data"]["id"].stringValue
                contact.age = resultJSON["data"]["age"].stringValue
                contact.photo = resultJSON["data"]["photo"].stringValue
                self.view?.updateUI(contact)
                
            }else{
                self.view?.showError()
            }
        }
    }
    
    func addContact(_ model : Contact) {
        print (model)
        
        Alamofire.request(self.baseURL + "/contact",
                          method: .post,
                          parameters: self.toJSON(model).dictionaryObject,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                        
                            if (response.response?.statusCode == 201){
                        
                                let resultJSON : JSON = JSON(response.result.value!)
                                self.view?.showSuccess(resultJSON["message"].stringValue)
                            }else{
                                self.view?.showError()
                            }
                            
        }
    }
    
    func editContact(_ model : Contact, _ id : String) {
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .put,
            parameters: self.toJSON(model).dictionaryObject,
            encoding: JSONEncoding.default).responseJSON { (response) in
                
                if (response.response?.statusCode == 201){
                    
                    let resultJSON : JSON = JSON(response.result.value!)
                    self.view?.showSuccess(resultJSON["message"].stringValue)
                }
                else{
                    self.view?.showError()
                }
        }
    }
    
    func deleteContact(_ id : String){
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .delete).responseJSON { (response) in
                if (response.response?.statusCode == 201){
                    
                    let resultJSON : JSON = JSON(response.result.value!)
                    self.view?.showSuccess(resultJSON["message"].stringValue)
                }
                else{
                    self.view?.showError()
                }
        }
    }
}
