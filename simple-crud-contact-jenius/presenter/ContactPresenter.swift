//
//  ContactPresenter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

class ContactPresenter : ListViewToPresenterProtocol{
    var interactor : PresenterToInteractorProtocol?
    var listView : PresenterToListViewProtocol?
    var detailView : PresenterToDetailViewProtocol?
    func fetchListContacts(){
        interactor?.getContacts()
    }
}

extension ContactPresenter : DetailViewToPresenterProtocol{
    func fetchContact(_ id : String){
        interactor?.getContact(id)
    }
    
    func addContact(_ contact : Contact){
        interactor?.addContact(contact)
    }
    
    func editContact(_ id : String,_ contact : Contact){
        interactor?.editContact(id, contact)
    }
    
    func deleteContact(_ id : String){
        interactor?.deleteContact(id)
    }
}

extension ContactPresenter : InteractorToPresenterProtocol{
    func listContactFetchSuccess(_ contacts: [Contact]) {
        listView?.fetchSucceed(contacts: contacts)
    }
    
    func listContactFetchFailed() {
        listView?.handleError()
    }
    
    func contactFetchSuccess(_ contact: Contact) {
        detailView?.fetchSucceed(contact: contact)
    }
    
    func contactFetchFailed() {
        detailView?.handleError()
    }
    
    func addContactSuccess(_ message: String) {
        detailView?.showSuccessMessage(message)
    }
    
    func addContactFailed() {
        detailView?.handleError()
    }
    
    func editContactSuccess(_ message: String) {
        detailView?.showSuccessMessage(message)
    }
    
    func editContactFailed() {
        detailView?.handleError()
    }
    
    func deleteContactSuccess(_ message: String) {
        detailView?.showSuccessMessage(message)
    }
    
    func deleteContactFailed() {
        detailView?.handleError()
    }
    

}
