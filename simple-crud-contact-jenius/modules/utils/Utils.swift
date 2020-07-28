//
//  Utils.swift
//  simple-crud-contact-jenius
//
//  Created by Josephine Fransisca on 28/07/20.
//  Copyright © 2020 Adhika gunadarma. All rights reserved.
//

import UIKit
import Foundation

class Utils{
    
    static func presentAlert(_ messageText : String) -> UIAlertController{
        // function to present popup alert
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
}
