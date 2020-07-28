//
//  DetailViewController.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 06/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD
import SDWebImage

class DetailViewController: UIViewController {
    
    internal var id_contact : String = ""
    private let hud = JGProgressHUD()
    lazy var presenter = DetailContactPresenter(with: self) // init pas dipanggil aja
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var contactPhoto: UIImageView!
    
    @IBOutlet weak var contactFirst: UITextField!
    @IBOutlet weak var contactLast: UITextField!
    @IBOutlet weak var contactAge: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        self.hud.show(in : self.view)
        presenter.deleteContact(id_contact)
    }
    
    // function to submit the data contact, whether it is add a new one or edit an existing one, depends on the contact id passed to the page
    @IBAction func onSubmit(_ sender: Any) {
        
        self.hud.show(in : self.view)
        
        let age = Int(self.contactAge.text ?? "") ?? 0
        let firstName = self.contactFirst.text ?? ""
        let lastName = self.contactLast.text ?? ""
        let photo = self.contactPhoto.sd_imageURL?.absoluteString ?? "N/A"
        
        if (self.id_contact != ""){ // edit
            presenter.editContact(age, firstName, lastName, photo ,self.id_contact)
        }else{ // add new
            presenter.addContact(age, firstName, lastName, photo)
        }
    }
    
    
    private func setupData(){
        if (id_contact != ""){
            self.hud.show(in: self.view)
            presenter.getContact(self.id_contact)
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
}

extension DetailViewController : PresenterDetailView{
    
    
    func updateUI(_ contactVM : ContactViewModel){
        self.hud.dismiss()
        self.contactFirst.text = contactVM.firstName
        self.contactLast.text = contactVM.lastName
        self.contactAge.text = contactVM.age
        if (!contactVM.noPhoto){
            self.contactPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.contactPhoto.sd_setImage(with: URL(string: contactVM.photo), placeholderImage: nil)
        }else{
            self.contactPhoto.image = UIImage(named: "noimageavailable")
        }
    }
    
    func showSuccess(_ message : String) {
        let alert = Utils.presentAlert(message)
        self.present(alert, animated: true, completion: nil)
        self.hud.dismiss()
    }
    
    func showError(_ message : String) {
        let alert = message == "" ? Utils.presentAlert("Something goes wrong..") : Utils.presentAlert(message)
        self.present(alert, animated: true, completion: nil)
        self.hud.dismiss()
    }
    
    
}
