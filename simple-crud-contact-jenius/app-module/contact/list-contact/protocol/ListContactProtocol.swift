//
//  ContactProtocol.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation


protocol ViewToPresenterListProtocol{
    var view: PresenterToViewListProtocol? {get set}
    var interactor: PresenterToInteractorListProtocol? {get set}
    var router: PresenterToRouterListProtocol? {get set}

    func fetchListContacts()
}

protocol PresenterToViewListProtocol{
    func fetchSucceed(contacts : [DetailContact])
    func handleError()
}

protocol PresenterToInteractorListProtocol{
    
    var presenter:InteractorToPresenterListProtocol? {get set}
    func getContacts()
    
}

protocol InteractorToPresenterListProtocol{
    func listContactFetchSuccess(_ contacts : [DetailContact])
    func listContactFetchFailed()
    
}


protocol PresenterToRouterListProtocol{
    static func createListContactModule()->ListViewController
}

