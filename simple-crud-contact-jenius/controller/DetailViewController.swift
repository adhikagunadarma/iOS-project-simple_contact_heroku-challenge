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

class DetailViewController: UIViewController {
    
    internal var id_contact : String = ""
    private var contact = Contact()
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    private let hud = JGProgressHUD()
    
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
        self.deleteContact(self.id_contact)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let contact = Contact()
        contact.age = self.contactAge.text ?? ""
        contact.firstName = self.contactFirst.text ?? ""
        contact.lastName = self.contactLast.text ?? ""
        contact.photo = "sdf"
        if (self.id_contact != ""){
            self.editContact(contact, self.id_contact)
        }else{
            self.addNewContact(contact)
        }
    }
    
    private func setupData(){
        if (id_contact != ""){
            self.getContact(id_contact)
        }else{
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func updateUI(_ contact : Contact){
        self.contactFirst.text = contact.firstName
        self.contactLast.text = contact.lastName
        self.contactAge.text = contact.age
        //        self.contactPhoto.text = self.contact.photo
    }
    
    private func toJSON(_ contact : Contact) -> JSON {
        return [
            "firstName": contact.firstName as Any,
            "lastName": contact.lastName as Any,
            "age": contact.age as Any,
            "photo": contact.photo as Any
            
        ]
    }
    
    private func getContact(_ id : String){
        self.hud.show(in: self.view)
        Alamofire.request(self.baseURL + "/contact/\(id)", method: .get).responseJSON { (response) in
            
            self.hud.dismiss()
            if (response.result.isSuccess){
                // fetch and convert the response into JSON
                let resultJSON : JSON = JSON(response.result.value!)
                let contact = Contact()
                contact.firstName = resultJSON["data"]["firstName"].stringValue
                contact.lastName = resultJSON["data"]["lastName"].stringValue
                contact.id = resultJSON["data"]["id"].stringValue
                contact.age = resultJSON["data"]["age"].stringValue
                contact.photo = resultJSON["data"]["photo"].stringValue
                self.updateUI(contact)
                
            }else{
                self.presentAlert("Result not found")
            }
        }
    }
    
    private func addNewContact(_ model : Contact) {
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact",
                          method: .post,
                          parameters: self.toJSON(model).dictionaryObject,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            
                            self.hud.dismiss()
                            let resultJSON : JSON = JSON(response.result.value!)
                            self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func editContact(_ model : Contact, _ id : String) {
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .put,
            parameters: self.toJSON(model).dictionaryObject,
            encoding: JSONEncoding.default).responseJSON { (response) in
                
                self.hud.dismiss()
                let resultJSON : JSON = JSON(response.result.value!)
                self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func deleteContact(_ id : String){
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .delete).responseJSON { (response) in
                
                self.hud.dismiss()
                let resultJSON : JSON = JSON(response.result.value!)
                self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func presentAlert(_ messageText : String){
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
