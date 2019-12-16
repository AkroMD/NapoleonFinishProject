
import UIKit

class AddPatternViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var recordText: UITextField!
    @IBOutlet weak var tablePattern: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameText: UILabel!
    
        var indexEdit = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        indexEdit = -1
        cancelButton.isHidden = true
        deleteButton.isHidden = true
        saveButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        titleText.text = ""
        recordText.text = ""
        tablePattern.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        PatternController.deletePattern(index: indexEdit, type: PatternController.currentPattern) {message in
            Message.message(title: "Удаление", message: message, presentationController: self, sourceView: self.titleText) {
                self.tablePattern.reloadData()
            }
        }
        cancelAction(sender)
    }
    
    
    @IBAction func addPatternAction(_ sender: Any) {
        if (titleText.text == nil) {
            Message.message(title: "Ошибка", message: "Введите заголовок", presentationController: self, sourceView: self.titleText)
            return
        }
        let title = titleText.text!
        let text = recordText.text ?? ""
        
        if (indexEdit >= 0) {
            PatternController.editPattern(index: indexEdit, type: PatternController.currentPattern, title: title, text: text) { message in
                Message.message(title: "Изменение", message: message, presentationController: self, sourceView: self.titleText) {
                    self.tablePattern.reloadData()
                }                
            }
            return
        }

        PatternController.addPattern(type: PatternController.currentPattern, title: title, text: text) { message in
            Message.message(title: "Добавление", message: message, presentationController: self, sourceView: self.titleText) {
                self.tablePattern.reloadData()
            }
        }
    }
    
    func load() {
        let name: String
        if (PatternController.currentPattern == 1) {
            name = "Шаблоны услуг"
        } else {
          name = "Шаблоны уведомлений"
        }
        nameText.text = name
        cancelAction(self)
    }
    
}

extension AddPatternViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pattern: PatternRecord
        if (PatternController.currentPattern == 1) {
            pattern = PatternController.proceduresPattern[indexPath.row]
        }
            else {
            pattern = PatternController.notificationsPattern[indexPath.row]
        }
        self.recordText.text = pattern.text
        self.titleText.text = pattern.title
        self.indexEdit = indexPath.row
        self.cancelButton.isHidden = false
        self.deleteButton.isHidden = false
        self.saveButton.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (PatternController.currentPattern == 1) {
            return PatternController.proceduresPattern.count
        }
        return PatternController.notificationsPattern.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pattern: PatternRecord
        if (PatternController.currentPattern == 1) {
            pattern = PatternController.proceduresPattern[indexPath.row]
        }
            else {
            pattern = PatternController.notificationsPattern[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternTableCell") as! PatternTableViewCell
        cell.setup(title: pattern.title)
        return cell
    }
    
    
}
