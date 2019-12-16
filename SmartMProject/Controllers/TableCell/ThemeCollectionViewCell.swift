//
//  ThemeCollectionViewCell.swift
//  SmartMProject
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    func setup(color: UIColor) {
        backgroundColor = color
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
}
