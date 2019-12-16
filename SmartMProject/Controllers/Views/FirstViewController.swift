//
//  ViewController.swift
//  SmartMProject
//
//  Created by Admin on 04/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    

    @IBOutlet weak var logoText: TItleView!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var backImage: UIView!
    @IBOutlet var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainController.load() {
            startAnimated()
        }
    }
    
    func startAnimated() {
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
            self.backView.backgroundColor = ProfileCompanyController.colorBack
            self.backImage.backgroundColor = ProfileCompanyController.colorMainBack
            self.logoText.textColor = ProfileCompanyController.colorBack
            self.logoText.alpha = 1
            self.mImage.alpha = 0
            self.backImage.layer.cornerRadius = 200
            self.backImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        }, completion: {finish in
            self.afterLoad()
        })
    }
    
    func afterLoad() {        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ContactsViewController")
        self.present(vc, animated: false, completion: nil)
    }


}

