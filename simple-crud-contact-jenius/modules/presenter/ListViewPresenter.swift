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

protocol PresenterListView : class {
    func updateUI(_ contacts : [Contact])
    func showError()
}

class ListContactPresenter{
    weak var view: PresenterListView?
    
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    init(with view: PresenterListView) {
        self.view = view
    }
    
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
                self.view?.updateUI(contacts)
            }else{
                self.view?.showError()
            }
        }
    }
}
