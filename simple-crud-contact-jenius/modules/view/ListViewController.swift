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

// If you somehow read this
// The code is kinda messed up, I'm relatively new with swift programming and i have not familiar with the design pattern yet, I'm trying to implement VIPER design pattern, but could not get it done due to time constraint, so I'm doing whatever I could to make the app work first.
//  I will try my hands on unit testing and revamping the code using Viper design pattern on different branch, the master branch will not be changed.
class ListViewController: UIViewController {
    @IBOutlet weak var addNewContact: UIBarButtonItem!
    @IBOutlet weak var contactTableView: UITableView!
    
    lazy var presenter = ListContactPresenter(with: self) // init pas dipanggil aja
    private var contactsVM : [ContactViewModel] = []
    private let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // when the view controller is shown, will fetch the new data from the API ,so it will kept us updated with any changes on the API
        self.hud.show(in: self.view)
        presenter.getAllContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // since there are 2 ways to access detail view controller, one with params, and the other without param to indicate whether the detail VC should call edit or add new contact api call
        let destVC : DetailViewController = segue.destination as! DetailViewController
        if (segue.identifier == "goToDetailWithParams"){
            let selectedRow = contactTableView.indexPathForSelectedRow!.row
            destVC.id_contact = self.contactsVM[selectedRow].id
        }
    }
    
}


extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    
    //standard tableview delegate method to be implemented
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ContactViewCell
        cell.nameContact.text = self.contactsVM[indexPath.row].name
        return cell
    }
    
    
}

extension ListViewController : PresenterListView {
    func updateUI(_ contacts : [ContactViewModel]) {
        self.contactsVM = contacts
        self.hud.dismiss()
        self.contactTableView.reloadData()
    }
    
    func showError(_ message : String) {
        
        let alert = message == "" ? Utils.presentAlert("Something goes wrong..") : Utils.presentAlert(message)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
