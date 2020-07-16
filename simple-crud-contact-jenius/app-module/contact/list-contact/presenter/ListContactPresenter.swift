//
//  ContactPresenter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation

class ListContactPresenter : ViewToPresenterListProtocol{
    var router: PresenterToRouterListProtocol?
    var interactor : PresenterToInteractorListProtocol?
    var view : PresenterToViewListProtocol?
    
    func fetchListContacts(){
        print("sdf")
        interactor?.getContacts()
    }
}



extension ListContactPresenter : InteractorToPresenterListProtocol{
    func listContactFetchSuccess(_ contacts: [DetailContact]) {
        print("gxx")
        view?.fetchSucceed(contacts: contacts)
    }
    
    func listContactFetchFailed() {
        view?.handleError()
    }
    
    

}
