//
//  ContactProtocol.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol? {get set}
    var interactor: PresenterToInteractorDetailProtocol? {get set}
    var router: PresenterToRouterDetailProtocol? {get set}
    
    func fetchContact(_ id : String)
    func addContact(_ contact : DetailContact)
    func editContact(_ id : String,_ contact : DetailContact)
    func deleteContact(_ id : String)
}

protocol PresenterToViewDetailProtocol{
    func fetchSucceed(contact : DetailContact)
    func showSuccessMessage(_ message : String)
    func handleError()
}

protocol PresenterToInteractorDetailProtocol{
    
    var presenter:InteractorToPresenterDetailProtocol? {get set}
    func getContact(_ id : String)
    func addContact(_ contact : DetailContact)
    func editContact(_ id : String,_ contact : DetailContact)
    func deleteContact(_ id : String)
    
}

protocol InteractorToPresenterDetailProtocol{
    func contactFetchSuccess(_ contact : DetailContact)
    func contactFetchFailed()
    func addContactSuccess(_ message : String)
    func addContactFailed()
    func editContactSuccess(_ message : String)
    func editContactFailed()
    func deleteContactSuccess(_ message : String)
    func deleteContactFailed()
    
}


protocol PresenterToRouterDetailProtocol{
    static func createDetailContactModule()->DetailViewController
}
