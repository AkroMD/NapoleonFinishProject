import UIKit

class AddClientViewController: UIViewController {

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var telephoneText: UITextField!
    @IBOutlet weak var vkText: UITextField!
    @IBOutlet weak var additionInfoText: UITextField!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var imagePicker: ImagePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepeare()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepeare()
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func deleteClient(_ sender: Any) {
        MainController.deleteClient {message in
            Message.message(title: "Удаление", message: message, presentationController: self, sourceView: self.deleteButton) {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func telephoneContactsAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TelephoneView")
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func backView(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addContact(_ sender: Any) {
        
        if (nameText.text != nil && nameText.text != "") {
            let name = nameText.text!
            let telephone = telephoneText.text
            let photo = imagePhoto.image
            let additionInfo = additionInfoText.text
            let vk = vkText.text
            
            if (MainController.isSelectClient) {
                MainController.editClient(name: name, telephone: telephone, vk: vk, additionalInfo: additionInfo, photo: photo) {message in
                    Message.message(title: "Изменение", message: message, presentationController: self, sourceView: self.additionInfoText) {
                        self.dismiss(animated: true)
                    }
                }
            }
            else {
                MainController.addClient(name: name, telephone: telephone,vk: vk, additionalInfo: additionInfo, photo: photo) {message in
                    Message.message(title: "Добавление", message: message, presentationController: self, sourceView: self.additionInfoText) {
                        MainController.clearTempClient()
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    func fillData(client: Client) {
        nameText.text = client.name
        telephoneText.text = client.telephone
        vkText.text = client.vk
        additionInfoText.text = client.additionalInfo
        imagePhoto.image = UIImage(data: client.photo as Data)
        if (imagePhoto.image != nil) {
            addPhotoButton.alpha = 0.1
        }
    }
    
    func prepeare() {
        
        if (!MainController.isSelectClient) {
            deleteButton.isHidden = true
            if (MainController.isTempClient) {
                let client = MainController.getTempClient()
                fillData(client: client)
            }
            return
        }
        
        saveButton.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        let client = MainController.selectClient        
        fillData(client: client)
    }
    
    
}

extension AddClientViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imagePhoto.image = image
        if (image != nil) {
            addPhotoButton.alpha = 0.1
        }
    }

}
