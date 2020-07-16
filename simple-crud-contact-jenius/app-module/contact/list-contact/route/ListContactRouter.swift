//
//  ListContactRouter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 15/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation
import UIKit


class ListContactRouter:PresenterToRouterListProtocol{
    static func createListContactModule() -> ListViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        var presenter: ViewToPresenterListProtocol & InteractorToPresenterListProtocol = ListContactPresenter()
        var interactor: PresenterToInteractorListProtocol = ListContactInteractor()
        let router:PresenterToRouterListProtocol = ListContactRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
//    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
//
//        let movieModue = MovieRouter.createMovieModule()
//        navigationController.pushViewController(movieModue,animated: true)
//
//    }
    
    
}
