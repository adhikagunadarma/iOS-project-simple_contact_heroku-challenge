//
//  ContactPresenter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation



class DetailContactPresenter : ViewToPresenterDetailProtocol{
    var router: PresenterToRouterDetailProtocol?
    var interactor : PresenterToInteractorDetailProtocol?
    var view : PresenterToViewDetailProtocol?
    
    func fetchContact(_ id : String){
        interactor?.getContact(id)
    }
    
    func addContact(_ contact : DetailContact){
        interactor?.addContact(contact)
    }
    
    func editContact(_ id : String,_ contact : DetailContact){
        interactor?.editContact(id, contact)
    }
    
    func deleteContact(_ id : String){
        interactor?.deleteContact(id)
    }
}

extension DetailContactPresenter : InteractorToPresenterDetailProtocol{
  
    func contactFetchSuccess(_ contact: DetailContact) {
        view?.fetchSucceed(contact: contact)
    }
    
    func contactFetchFailed() {
        view?.handleError()
    }
    
    func addContactSuccess(_ message: String) {
        view?.showSuccessMessage(message)
    }
    
    func addContactFailed() {
        view?.handleError()
    }
    
    func editContactSuccess(_ message: String) {
        view?.showSuccessMessage(message)
    }
    
    func editContactFailed() {
        view?.handleError()
    }
    
    func deleteContactSuccess(_ message: String) {
        view?.showSuccessMessage(message)
    }
    
    func deleteContactFailed() {
        view?.handleError()
    }
    

}
