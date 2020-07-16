//
//  ContactRouter.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 09/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import Foundation
import UIKit

class DetailContactRouter:PresenterToRouterDetailProtocol{
    static func createDetailContactModule() -> DetailViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        var presenter: ViewToPresenterDetailProtocol & InteractorToPresenterDetailProtocol = DetailContactPresenter()
        var interactor: PresenterToInteractorDetailProtocol = DetailContactInteractor()
        let router:PresenterToRouterDetailProtocol = DetailContactRouter()
        
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
