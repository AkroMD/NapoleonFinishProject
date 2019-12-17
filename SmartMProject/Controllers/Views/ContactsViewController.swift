//
//  ContactsViewController.swift
//  SmartMProject
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var tableClients: UITableView!
    @IBOutlet weak var logoText: TItleView!
    @IBOutlet weak var nameCompanyText: UILabel!
    @IBOutlet weak var profileButton: ImageButton!
    @IBOutlet weak var addButton: ImageButton!
    @IBOutlet weak var mainView: MainBackView!
    @IBOutlet var backView: BackroundView!
    @IBOutlet weak var indicatorLoad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        indicatorLoad.isHidden = false
        profileButton.isUserInteractionEnabled = false
        addButton.isUserInteractionEnabled = false
        tableClients.isUserInteractionEnabled = false
        
        MainController.reloadCLient() {
            DispatchQueue.main.async {
                self.tableClients.reloadData()
                self.indicatorLoad.isHidden = true
                self.profileButton.isUserInteractionEnabled = true
                self.addButton.isUserInteractionEnabled = true
                self.tableClients.isUserInteractionEnabled = true
            }
        }
        mainView.backgroundColor = ProfileCompanyController.colorMainBack
        backView.backgroundColor = ProfileCompanyController.colorBack
        logoText.textColor = ProfileCompanyController.colorBack
        addButton.tintColor = ProfileCompanyController.colorButton
        profileButton.tintColor = ProfileCompanyController.colorButton
        nameCompanyText.text = ProfileCompanyController.profile.login
    }
    
    
    @IBAction func settingProfileAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingView")
        self.present(vc, animated: true)
    }
    
    @IBAction func addContact(_ sender: Any) {
        MainController.indexClient = -1
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddClientView")
        self.present(vc, animated: true)
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainController.clients.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainController.indexClient = indexPath.row
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ClientViewController")
        self.present(vc, animated: true)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Заполнение
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell") as! ClientTableViewCell
        let client = MainController.clients[indexPath.row]
        let name = client.name
        let notification = client.isActiveProcedure()
        let lastProcedure = client.getLastProcedureText()
        let photo: UIImage? = UIImage(data: client.photo as Data)
        
        cell.setup(name: name, notification: notification, lastprocedure: lastProcedure, photo: photo)
        
        //Эффектный выход
        let degree: Double = 90
        let rotationAnge = CGFloat(degree * .pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAnge, 0, 1, 0)
        cell.layer.transform = rotationTransform
        let delay: Double = 0.1 + 0.3 * Double(indexPath.row)
        UIView.animate(withDuration: 0.6, delay: delay, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
        
        return cell
    }
    
    
}
