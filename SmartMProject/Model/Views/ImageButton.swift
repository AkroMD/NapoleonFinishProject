//
//  ImageButton.swift
//  SmartMProject
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = ProfileCompanyController.colorButton
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tintColor = ProfileCompanyController.colorButton
    }

}
