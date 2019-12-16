//
//  HistoryProcedureTableViewCell.swift
//  SmartMProject
//
//  Created by Admin on 09/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class HistoryProcedureTableViewCell: UITableViewCell {

    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var nameText: UITextField!
    

    func setup(text: String, date: NSDate) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let textDate = dateFormatter.string(from: date as Date)
        dateText.text = textDate
        nameText.text = text
    }
}
