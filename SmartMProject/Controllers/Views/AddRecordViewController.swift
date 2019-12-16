
import UIKit

class AddRecordViewController: UIViewController {

    @IBOutlet weak var recordText: UITextField!
    @IBOutlet weak var stateText: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicher: UIDatePicker!
    @IBOutlet weak var nameTitileText: UILabel!
    var stateSelect = State.failed
    
    
    
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
    
    @IBAction func addAction(_ sender: UIView) {
        //Проверка
        if (titleText.text == nil) {
            Message.message(title: "Ошибка", message: "Введите заголовок", presentationController: self, sourceView: sender)
            return
        }
        //Заполнение
        let textRecord = recordText.text ?? ""
        let date = datePicher.date as NSDate
        let title = titleText.text!
        //Изменение услуги
        if (MainController.isSelectProcedure) {
            MainController.editProcedureToClient(title: title, text: textRecord, date: date, state: .activ) {
                message in
                Message.message(title: "Изменение", message: message, presentationController: self, sourceView: sender) {
                    self.dismiss(animated: true)
            }
            }
        }
            //Отправка уведомления
        else if (PatternController.currentPattern == 2) {
            //Тут будет реализация отправки уведомлений
        }
            //Добалвение услуги
        else {
            MainController.addProcedureToClient(title: title, text: textRecord, date: date, state: .activ) { message in
                Message.message(title: "Добавление", message: message, presentationController: self, sourceView: sender) {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    func load() {
        if (PatternController.currentPattern == 1) {
            nameTitileText.text = "Добавление процедуры"
        } else {
            nameTitileText.text = "Отправка уведомления"
        }
        if (MainController.isSelectProcedure) {
            fillProcedure()
        }
    }
    
    func fillProcedure() {
        let procedure = MainController.selectProcedure
        stateSelect = State(rawValue: procedure.state)!
        stateText.text = procedure.state
        titleText.text = procedure.title
        recordText.text = procedure.text
        datePicher.date = procedure.date as Date
    }
}

extension AddRecordViewController: UITableViewDelegate, UITableViewDataSource {
    
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
