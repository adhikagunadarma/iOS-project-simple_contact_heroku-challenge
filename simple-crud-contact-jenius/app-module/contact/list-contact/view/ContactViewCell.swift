//
//  ContactViewCell.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 06/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var nameContact: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
