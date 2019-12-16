//
//  CornerButton.swift
//  SmartMProject
//
//  Created by Admin on 07/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class CornerButton: UIButton {

     @IBInspectable var cornerRadius: CGFloat = 10.0 {
         didSet {
             acceptCorner()
         }
     }
     
     @IBInspectable var leftTopCorner: Bool = false {
         didSet {
             acceptCorner()
         }
     }
     
     @IBInspectable var leftBottomCorner: Bool = false {
         didSet {
             acceptCorner()
         }
     }
     
     @IBInspectable var rightTopCorner: Bool = false {
         didSet {
             acceptCorner()
         }
     }
     
     @IBInspectable var rightBottomCorner: Bool = false {
         didSet {
             acceptCorner()
         }
     }
     
     @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 1) {
         didSet {
             self.layer.shadowOffset = shadowOffset
         }
     }
     
     @IBInspectable var shadowRadius: CGFloat = 1 {
            didSet {
                self.layer.shadowRadius = shadowRadius
            }
        }
     
     @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
            didSet {
             self.layer.shadowColor = shadowColor.cgColor
            }
        }

    
     func acceptCorner() {
         var maskCorner = CACornerMask()
         self.layer.cornerRadius = cornerRadius
         if (leftTopCorner) { maskCorner.insert(.layerMinXMinYCorner) }
         if (leftBottomCorner) { maskCorner.insert(.layerMinXMaxYCorner) }
         if (rightTopCorner) { maskCorner.insert(.layerMaxXMinYCorner) }
         if (rightBottomCorner) { maskCorner.insert(.layerMaxXMaxYCorner) }
         self.layer.maskedCorners = maskCorner
         self.layer.shadowOpacity = 1
     }

}
