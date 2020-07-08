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
    
    // function to submit the data contact, whether it is add a new one or edit an existing one, depends on the contact id passed to the page
    @IBAction func onSubmit(_ sender: Any) {
        let contact = Contact()
        contact.age = self.contactAge.text ?? ""
        contact.firstName = self.contactFirst.text ?? ""
        contact.lastName = self.contactLast.text ?? ""
        
        // Contact Photo Issue
        // I got an issue of how to upload an image from url, since the response of photo property is based on URL. It might be possible to upload the photo from camera or file directory, but the response.photo of the getContacts and getContact will be mixed up between URL and base64. Therefore for now, the solution is either hardcode the photo with fixed url or leave it out from the expected parameters for the api call.
        // For now I will leave it out from addNewContact, so there will be no photo when add the contact and using the existing photo for edit contact
        
        
        
        // check whether id is existing(goes to edit) or it is empty(goes to add new contact)
        if (self.id_contact != ""){ // edit
            // get the image url if it is not N/A which indicated that the contact does not have any photo
            contact.photo = self.contactPhoto.sd_imageURL?.absoluteString ?? "N/A"
            self.editContact(contact, self.id_contact)
        }else{ // add new
            self.addNewContact(contact)
        }
    }
    
    
    private func setupData(){
        if (id_contact != ""){
            // indicates that the view controller have the id, so the page will goes to editing instead of showing empty form
            self.getContact(id_contact)
        }else{
            // indicates that the view controller does not have the id, so the page will goes to add new contact and will hide the delete button on the top
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func updateUI(_ contact : Contact){
        // update the UI accordingly
        self.contactFirst.text = contact.firstName
        self.contactLast.text = contact.lastName
        self.contactAge.text = contact.age
        
        if (contact.photo != "N/A"){
            self.contactPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.contactPhoto.sd_setImage(with: URL(string: contact.photo), placeholderImage: nil)
        }else{
            self.contactPhoto.image = UIImage(named: "noimageavailable")
        }
        
        
    }
    
    private func toJSON(_ contact : Contact) -> JSON {
        // function to convert model into json because Alamofire only support json type of params
        return [
            "firstName": contact.firstName as Any,
            "lastName": contact.lastName as Any,
            "age": contact.age as Any,
            //            "photo": contact.photo as Any
            
        ]
    }
    
    private func getContact(_ id : String){
        // api call function to get contact
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
        // api call function to add new contact
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact",
                          method: .post,
                          parameters: self.toJSON(model).dictionaryObject,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            
                            self.hud.dismiss()
                            // since the response only contain property message whether succes or fail ,so there will be no logic condition for it
                            let resultJSON : JSON = JSON(response.result.value!)
                            self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func editContact(_ model : Contact, _ id : String) {
        // api call function to edit contact
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .put,
            parameters: self.toJSON(model).dictionaryObject,
            encoding: JSONEncoding.default).responseJSON { (response) in
                // since the response only contain property message whether succes or fail ,so there will be no logic condition for it
                self.hud.dismiss()
                let resultJSON : JSON = JSON(response.result.value!)
                self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func deleteContact(_ id : String){
        // api call function to delete contact
        self.hud.show(in: self.view)
        
        
        Alamofire.request(self.baseURL + "/contact/\(id)",
            method: .delete).responseJSON { (response) in
                // since the response only contain property message whether succes or fail ,so there will be no logic condition for it
                self.hud.dismiss()
                let resultJSON : JSON = JSON(response.result.value!)
                self.presentAlert(resultJSON["message"].stringValue)
        }
    }
    
    private func presentAlert(_ messageText : String){
        // api call function to presen alert popup
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
