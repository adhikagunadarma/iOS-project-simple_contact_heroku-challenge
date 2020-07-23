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
    func showError(_ message : String)
}

class DetailContactPresenter{
    weak var view: PresenterDetailView?
    
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    init(with view: PresenterDetailView) {
        self.view = view
    }
    
    func getContact(_ id : String){
        // api call function to get contact
        Alamofire.request(self.baseURL + "/contact/\(id)", method: .get).responseData { (response) in
            
            
            switch (response.result){
            case .success(let data) :
                guard let contactData = try? JSONDecoder().decode(DetailContact.self, from: data) else {
                  
                  self.view?.showError("")
                  return
                }
                
                let contact = contactData.data
                self.view?.updateUI(contact)
                break
                
                
            case .failure(let error) :
                
                self.view?.showError(error.localizedDescription)
                break
                
            }

        }
    }
    
    func addContact(_ model : Contact) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let contactJSON = try encoder.encode(model)

            if let jsonString = String(data: contactJSON, encoding: .utf8) {
                Alamofire.request(self.baseURL + "/contact",
                                  method: .post,
                                  parameters: model,
                                  encoding: JSONEncoding.default).responseJSON { (response) in
                                
                                    if (response.response?.statusCode == 201){
                                
                                        let resultJSON : JSON = JSON(response.result.value!)
                                        self.view?.showSuccess(resultJSON["message"].stringValue)
                                    }else{
                                        self.view?.showError("")
                                    }
                                    
                }
            }
        } catch {
            print(error.localizedDescription)
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
                    self.view?.showError("")
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
                    self.view?.showError("")
                }
        }
    }
}
