//
//  ClientInfoViewController.swift
//  SmartMProject
//
//  Created by Admin on 10/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit

class ClientInfoViewController: UIViewController {

    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var telephoneText: UILabel!
    @IBOutlet weak var vkText: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var additionInfoText: UILabel!    
    @IBOutlet weak var notClientText: UILabel!
    @IBOutlet weak var notificationButton: CornerButton!
    @IBOutlet weak var completeButton: CornerButton!
    @IBOutlet weak var addProcedureButton: UIButton!
    @IBOutlet weak var nameActivProcedureText: UILabel!
    @IBOutlet weak var tableProcedures: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInfo()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func editAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddClientView")
        self.present(vc, animated: true)
    }
    
    @IBAction func completeProcedureAction(_ sender: Any) {
        MainController.completionProcedureToClient() { message in
            Message.message(title: "Завершение", message: message, presentationController: self, sourceView: self.completeButton) {
                self.loadInfo()
                self.tableProcedures.reloadData()
            }
        }
    }
    
    @IBAction func addProcedureAction(_ sender: Any) {
        PatternController.currentPattern = 1
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "addRecordView")
        self.present(vc, animated: true)
    }
    
    @IBAction func addNotificationAction(_ sender: Any) {
        PatternController.currentPattern = 2
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "addRecordView")
        self.present(vc, animated: true)
    }
    
    func loadInfo() {
        if !MainController.isSelectClient {
            dismiss(animated: true)
            return
        }
        let client = MainController.selectClient
        nameText.text = client.name
        if (client.telephone == "") {
            telephoneText.text = "Не указан"
        } else {
            telephoneText.text = client.telephone
        }
        if (client.vk == "") {
            vkText.text = "Не указан"
        } else {
            vkText.text = client.vk
        }
        let image = UIImage(data: client.photo as Data)
        photoImage.image = image
        if (client.additionalInfo == "") {
            additionInfoText.text = "Не указано"
        } else {
            additionInfoText.text = client.additionalInfo
        }
        
        notClientText.isHidden = client.procedures.count > 0
        
        if (client.isActiveProcedure()) {
            let procedureActive = client.getActivProcedure()!
            completeButton.isHidden = false
            addProcedureButton.setImage(UIImage(systemName: "pencil.slash"), for: .normal)
            nameActivProcedureText.text = procedureActive.title + " " + procedureActive.date.toString()
        }
        else {
            completeButton.isHidden = true
        }
    }


}

extension ClientInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MainController.selectClient.procedures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let client = MainController.selectClient
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryClientCell") as! HistoryProcedureTableViewCell
        let procedure = client.procedures[indexPath.row]
        cell.setup(text: procedure.text, date: procedure.date)
        return cell
    }
    
    
}
