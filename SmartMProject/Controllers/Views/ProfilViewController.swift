import UIKit

class ProfilViewController: UIViewController {
    
    
    @IBOutlet weak var nameCompanyText: UITextField!
    @IBOutlet weak var themeView: UIView!
    var currentTheme = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func settingProcedureAction(_ sender: Any) {
        PatternController.currentPattern = 1
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddPatternView")
        self.present(vc, animated: true)
    }
    
    @IBAction func settingNotificationAction(_ sender: Any) {
        PatternController.currentPattern = 2
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddPatternView")
        self.present(vc, animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (nameCompanyText.text == nil) {
            Message.message(title: "Ошибка", message: "Добавьте логин", presentationController: self, sourceView: nameCompanyText)
            return
        }
        ProfileCompanyController.setProfileInfo(login: nameCompanyText.text!, themeID: currentTheme) { message in
            Message.message(title: "Успех", message: message, presentationController: self, sourceView: nameCompanyText) {
                self.dismiss(animated: true)
                
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func editTheme(index: Int) {
        currentTheme = index
        themeView.backgroundColor = ProfileCompanyController.themeApp[currentTheme].colorBack
    }
    
    func load() {
        let profile = ProfileCompanyController.profile
        nameCompanyText.text = profile.login
        editTheme(index: profile.themeID)
    }
    
}

extension ProfilViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.editTheme(index: indexPath.row)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileCompanyController.themeApp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCell", for: indexPath) as! ThemeCollectionViewCell
        cell.setup(color: ProfileCompanyController.themeApp[indexPath.row].colorBack)
        return cell
    }
    
}
