import Foundation


class ProceduresController {
    
    static var isSelectProcedure: Bool {
        get {
            return (indexProcedure >= 0)
        }
    }
    
    static var selectProcedure: Record {
        get {
            let selectClient = selectСlient
            return selectClient.procedures[indexProcedure]
        }
    }
    
    static func addProcedureToClient(title: String, text: String, date: NSDate, state: State, completion: @escaping (String) -> Void) {
        let procedure = Record()
        procedure.title = title
        procedure.date = date
        procedure.text = text
        procedure.state = state.rawValue
        let client = clients[indexClient]
        if ((try? realm.write {
                client.procedures.append(procedure)
            }) != nil) {
            completion("Процедура добавлена")
            return
        }
        completion("Неожиданный поворот")
    }
    
    static func editProcedureToClient(title: String, text: String, date: NSDate, state: State, completion: @escaping (String) -> Void) {
        let procedure = Record()
        procedure.date = date
        procedure.title = title
        procedure.text = text
        procedure.state = state.rawValue
        let client = clients[indexClient]
        if ((try? realm.write {
                client.procedures[indexProcedure] = procedure
            }) != nil) {
            completion("Процедура изменена")
            return
        }
        completion("Неожиданный поворот")
    }
    
    static func completionProcedureToClient(completion: @escaping (String) -> Void) {
        let client = clients[indexClient]
        let newProcedure = Record()
        let oldProcedure = client.procedures[indexProcedure]
        newProcedure.date = oldProcedure.date
        newProcedure.text = oldProcedure.text
        newProcedure.title = oldProcedure.title
        newProcedure.state = State.unactiv.rawValue
        
        if ((try? realm.write {
                client.procedures[indexProcedure] = newProcedure
            }) != nil) {
            completion("Процедура изменена")
            return
        }
        completion("Неожиданный поворот")
    }
    
    static func deleteProcedureToClient(completion: @escaping (String) -> Void) {
        let client = clients[indexClient]
        if ((try? realm.write {
                client.procedures.remove(at: indexProcedure)
            }) != nil) {
            completion("Процедура удалена")
            return
        }
        completion("Неожиданный поворот")
    }
}
