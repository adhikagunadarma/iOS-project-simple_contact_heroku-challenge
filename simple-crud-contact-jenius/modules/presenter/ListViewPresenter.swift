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
    func updateUI(_ contacts : [ContactViewModel])
    func showError(_ message : String)
}

class ListContactPresenter{
    weak var view: PresenterListView?
    
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    
    init(with view: PresenterListView) {
        self.view = view
    }
    
    func getAllContacts(){
        Alamofire.request(self.baseURL + "/contact", method: .get).responseData { (response) in
            
            switch (response.result){
            case .success(let data) :
                if (response.response?.statusCode == 200){
                    guard let contactData = try? JSONDecoder().decode(ListContact.self, from: data) else {
                        
                        self.view?.showError("")
                        return
                    }
                    
                    let contacts : [Contact] = contactData.data
                    let contactsViewModel : [ContactViewModel] = contacts.map({
                        return ContactViewModel(dataModel: $0)
                    })
                    self.view?.updateUI(contactsViewModel)
                }
                else{
                    self.view?.showError("status code is not 200")
                }
                
                break
                
                
            case .failure(let error) :
                
                self.view?.showError(error.localizedDescription)
                break
                
            }
            
        }
    }
}
