//
//  PatternTableViewCell.swift
//  SmartMProject
//
//  Created by Admin on 12/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class PatternTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    
    func setup(title: String) {
        titleText.text = title
    }
    
}
