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
        var contact = Contact()
        contact.age = Int(self.contactAge.text ?? "0")
        contact.firstName = self.contactFirst.text ?? ""
        contact.lastName = self.contactLast.text ?? ""
        self.hud.show(in : self.view)
        if (self.id_contact != ""){ // edit
            contact.photo = self.contactPhoto.sd_imageURL?.absoluteString ?? "N/A"
            presenter.editContact(contact,self.id_contact)
        }else{ // add new
            presenter.addContact(contact)
        }
    }
    
    
    private func setupData(){
        if (id_contact != ""){
            self.hud.show(in: self.view)
            presenter.getContact(id_contact)
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func presentAlert(_ messageText : String){
        // api call function to presen alert popup
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DetailViewController : PresenterDetailView{
  
    
    func updateUI(_ contact : Contact){
         // update the UI accordingly
        
         self.hud.dismiss()
         self.contactFirst.text = contact.firstName ?? ""
         self.contactLast.text = contact.lastName ?? ""
        
        if let contactAge = contact.age{
            self.contactAge.text = "\(contactAge)"
        }
        
        guard let contactPhoto = contact.photo else { return self.presentAlert("Photo is not initialized")}
        
         if (contactPhoto != "N/A"){
             self.contactPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
             self.contactPhoto.sd_setImage(with: URL(string: contactPhoto), placeholderImage: nil)
         }else{
             self.contactPhoto.image = UIImage(named: "noimageavailable")
         }
         
         
     }
    
    func showSuccess(_ message : String) {
        // kalo berhasil hit api, entah querynya berhasil ato engga
        self.presentAlert(message)
        self.hud.dismiss()
    }
    
    func showError(_ message : String) {
        message == "" ? self.presentAlert("Something goes wrong..") : self.presentAlert(message)

        self.hud.dismiss()
    }
    
    
}
