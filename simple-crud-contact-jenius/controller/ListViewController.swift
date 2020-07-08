//
//  ListViewController.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 06/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import SDWebImage
import JGProgressHUD
import SwiftyJSON
import Alamofire
import UIKit
let reuseIdentifier = "ContactCell"


// The code is kinda messed up, I'm trying to implement VIPER design pattern, but could not get it done due to time constraint, so I'm doing whatever I could to make the app work first.
class ListViewController: UIViewController {
    @IBOutlet weak var addNewContact: UIBarButtonItem!
    @IBOutlet weak var contactTableView: UITableView!
    private var contacts : [Contact] = []
    private let baseURL = "https://simple-contact-crud.herokuapp.com"
    private let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // when the view controller is shown, will fetch the new data from the API ,so it will kept us updated with any changes on the API
       self.getAllContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // since there are 2 ways to access detail view controller, one with params, and the other without param to indicate whether the detail VC should call edit or add new contact api call
        let destVC : DetailViewController = segue.destination as! DetailViewController
        if (segue.identifier == "goToDetailWithParams"){
            let selectedRow = contactTableView.indexPathForSelectedRow!.row
            destVC.id_contact = self.contacts[selectedRow].id
        }
    }
    
    private func getAllContacts(){
        // api call to get all contacts
        self.contacts = []
        self.hud.show(in: self.view)
        Alamofire.request(self.baseURL + "/contact", method: .get).responseJSON { (response) in
            
            self.hud.dismiss()
            if (response.result.isSuccess){
                // fetch and convert the response into JSON
                let resultJSON : JSON = JSON(response.result.value!)
                guard let listDataJSON = resultJSON["data"].array else{
                    return
                }
                
                for data in listDataJSON {
                    let contact = Contact()
                    contact.firstName = data["firstName"].stringValue
                    contact.lastName = data["lastName"].stringValue
                    contact.id = data["id"].stringValue
                    contact.age = data["age"].stringValue
                    contact.photo = data["photo"].stringValue
                    
                    self.contacts.append(contact)
                }
                self.contactTableView.reloadData()
                
            }else{
                self.presentAlert("Result not found")
            }
        }
        
    }
    
    private func presentAlert(_ messageText : String){
        // function to present popup alert
        let alert = UIAlertController(title: "Error", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    

    
    
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    
    //standard tableview delegate method to be implemented
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContactViewCell
        cell.nameContact.text = "\(self.contacts[indexPath.row].firstName) \(self.contacts[indexPath.row].lastName)"
        return cell
    }
    
    
}
