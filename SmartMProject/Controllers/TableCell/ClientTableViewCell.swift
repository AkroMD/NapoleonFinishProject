//
//  ClientTableViewCell.swift
//  SmartMProject
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var lastProcedureText: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    func setup(name: String, notification: Bool, lastprocedure: String?, photo: UIImage?) {
        nameText.text = name
        if (photo == nil) {
            self.photo.image = UIImage(systemName: "person.circle")
        } else {
            self.photo.image = photo
        }
        lastProcedureText.text = lastprocedure
        if (notification) {
            notificationButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        }
        else {
            notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        }
    }

}
