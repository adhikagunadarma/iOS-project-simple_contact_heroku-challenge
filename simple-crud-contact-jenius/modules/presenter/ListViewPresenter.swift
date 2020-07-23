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
                do{
                    let contactsData = try JSONDecoder().decode(ListContact.self, from: data)
                    
                    let contacts = contactsData.data
                    self.view?.updateUI(contacts)
                }catch let error{
                    print(error)

                    self.view?.showError("")
                }
                
                break
                
                
            case .failure(let error) :
                
                self.view?.showError(error.localizedDescription)
                break
                
            }
            
        }
    }
}
