//
//  ContactTelephoneTableViewCell.swift
//  SmartMProject
//
//  Created by Admin on 09/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ContactTelephoneTableViewCell: UITableViewCell {


    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var telephoneText: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    func setup (name: String, telephone: String?, photo: UIImage?) {
        nameText.text = name
        telephoneText.text = telephone
        photoImage.image = photo
    }
    
}
