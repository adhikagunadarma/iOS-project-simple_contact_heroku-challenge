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
                if (response.response?.statusCode == 200){
                    guard let contactData = try? JSONDecoder().decode(DetailContact.self, from: data) else {
                        
                        self.view?.showError("")
                        return
                    }
                    
                    let contact = contactData.data
                    self.view?.updateUI(contact)
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
    
    func addContact(_ model : Contact) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let contactEncoded = try encoder.encode(model)
            let addUrl = "\(self.baseURL)/contact"
            
            var request = URLRequest(url: URL(string: addUrl)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = contactEncoded
            
            Alamofire.request(request).responseData { (response) in
                
                
                switch (response.result){
                case .success(let data) :
                    if response.response?.statusCode == 201 {
                        guard let response = try? JSONDecoder().decode(ResponseAPI.self, from: data) else {
                            self.view?.showError("")
                            return
                        }
                        let message = response.message
                        self.view?.showSuccess(message)
                    }else{
                        self.view?.showError("Status code is not 201")
                    }
                    break
                case .failure(let error) :
                    self.view?.showError(error.localizedDescription)
                    break
                }
            }
        } catch {
            self.view?.showError(error.localizedDescription)
        }
    }
    
    func editContact(_ model : Contact, _ id : String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let contactEncoded = try encoder.encode(model)
            let addUrl = "\(self.baseURL)/contact/\(id)"
            
            var request = URLRequest(url: URL(string: addUrl)!)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = contactEncoded
            
            Alamofire.request(request).responseData { (response) in
                
                
                switch (response.result){
                case .success(let data) :
                    if response.response?.statusCode == 201 {
                        guard let response = try? JSONDecoder().decode(ResponseAPI.self, from: data) else {
                            self.view?.showError("")
                            return
                        }
                        let message = response.message
                        self.view?.showSuccess(message)
                    }else{
                        self.view?.showError("Status code is not 201")
                    }
                    break
                case .failure(let error) :
                    self.view?.showError(error.localizedDescription)
                    break
                }
            }
        } catch {
            self.view?.showError(error.localizedDescription)
        }
    }
    
    func deleteContact(_ id : String){
        
        let addUrl = "\(self.baseURL)/contact/\(id)"
        
        var request = URLRequest(url: URL(string: addUrl)!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        
        Alamofire.request(request).responseData { (response) in
            
            
            switch (response.result){
            case .success(let data) :
                if response.response?.statusCode == 201 {
                    
                    guard let response = try? JSONDecoder().decode(ResponseAPI.self, from: data) else {
                        self.view?.showError("")
                        return
                    }
                    let message = response.message
                    self.view?.showSuccess(message)
                }else{
                    self.view?.showError("Status code is not 201")
                }
                break
            case .failure(let error) :
                self.view?.showError(error.localizedDescription)
                break
            }
        }
        
    }
}

