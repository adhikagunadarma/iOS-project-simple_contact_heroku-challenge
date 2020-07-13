//
//  ContactProtocol.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

protocol ListViewToPresenterProtocol {
     func fetchListContacts()
}

protocol DetailViewToPresenterProtocol{
    func fetchContact(_ id : String)
    func addContact(_ contact : Contact)
    func editContact(_ id : String,_ contact : Contact)
    func deleteContact(_ id : String)
}

protocol PresenterToListViewProtocol{
    func fetchSucceed(contacts : [Contact])
    func handleError()
}

protocol PresenterToDetailViewProtocol{
    func fetchSucceed(contact : Contact)
    func showSuccessMessage(_ message : String)
    func handleError()
}

protocol PresenterToInteractorProtocol{

    func getContacts()
    func getContact(_ id : String)
    func addContact(_ contact : Contact)
    func editContact(_ id : String,_ contact : Contact)
    func deleteContact(_ id : String)
    
}

protocol InteractorToPresenterProtocol{
    func listContactFetchSuccess(_ contacts : [Contact])
    func listContactFetchFailed()
    func contactFetchSuccess(_ contact : Contact)
    func contactFetchFailed()
    func addContactSuccess(_ message : String)
    func addContactFailed()
    func editContactSuccess(_ message : String)
    func editContactFailed()
    func deleteContactSuccess(_ message : String)
    func deleteContactFailed()
    
}

