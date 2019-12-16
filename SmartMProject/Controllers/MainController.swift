import UIKit
import RealmSwift

class MainController {
    
    //Индекс выбранного клиента
    static var indexClient: Int = -1
    //Индекс выбранной процедуры
    static var indexProcedure: Int = -1
    private static var realm: Realm!
    
    static var clients: Results<Client> {
        get {
            return realm.objects(Client.self)
        }
    }
    
    //Переменная для переноса из одного контроллера в другой
    private static var tempClient: Client?
    
    private init() {}
    
    static func load(completion: () -> Void) {
        
        if (realm == nil) {
            realm = try! Realm()
            //информация о реалм, чтобы открыть базу через realm brouser
            print(Realm.Configuration.defaultConfiguration.description)
            PatternController.load(realm: realm)
            ProfileCompanyController.load(realm: realm)
        }
        //Для тестов
   //     API.clearBase() { _ in }
        
        if (clients.count == 0) { testClients() }       

        completion()
    }
    
    static func reloadCLient(completion: @escaping () -> Void) {
        API.loadContacts { clients in
            //Если пришли клиенты с сервера, то очищаем базу и заполняем прИшлыми
            clearRealmBase()
            for client in clients {
                addClient(client: client)
            }
            completion()
        }
    }
    
    //Section Client
    
    //Клиенты для теста
    static func testClients() {
        addClient(name: "Любовь", telephone: "9191279329", vk: nil, additionalInfo: nil, photo: nil) {_ in }
        addClient(name: "Валера", telephone: "hgfhfghfg", vk: nil, additionalInfo: nil, photo: nil) {_ in }
        addClient(name: "Тамара", telephone: nil, vk: "vk://fdsf", additionalInfo: "длинные ногти", photo: nil) {_ in }
        indexClient = 0
        addProcedureToClient(title: "Маникюр", text: "Розовый цвет, гель лак, ремонт ногтя", date: NSDate(), state: .unactiv) {_ in}
        indexClient = 1
        addProcedureToClient(title: "Укрепление ногтя", text: "стандартно", date: NSDate(), state: .activ) {_ in}
    }
    
    static var isSelectClient: Bool {
        get {
            return (indexClient >= 0)
        }
    }
    
    static var selectClient: Client {
        get {
            return clients[indexClient]
        }
    }
    
    static func addClient(client: Client) {
                
        if ((try? realm.write {
                realm.add(client, update: .modified)
            }) != nil) { return }
    }
    
    static func clearRealmBase() {
        if ((try? realm.write {
                realm.delete(clients)
            }) != nil) { return }
    }
    
    static func addClient(name: String, telephone: String?, vk: String?, additionalInfo: String?, photo: UIImage?, completion: (String) -> Void) {
        
        //Создаем объект с полями
        let client = Client()
        client.name = name
        client.telephone = telephone ?? ""
        client.additionalInfo = additionalInfo ?? ""
        var nsData = NSData()
        if (photo != nil) {
            nsData = NSData(data: photo!.pngData()!)
        }
        client.photo = nsData
        client.vk = vk ?? ""
        
        client.id = client.telephone+NSDate().toString()
        client.id = client.id.components(separatedBy: .whitespaces).joined()
        client.id = client.id.components(separatedBy: .punctuationCharacters).joined()
        //отправляем на сервер
        API.createContac(client: client) { _ in  }
        
        //Обновляем базу
        if ((try? realm.write {
                realm.add(client, update: .modified)
            }) != nil) {
            completion("Клиент добавлен")
            return
        }

        completion("Неожиданный поворот")
    }
    
    static func deleteClient(completion: @escaping (String) -> Void) {
        let client = selectClient
        
        API.deleteContact(contactID: client.id) { _ in }
        
        if ((try? realm.write {
                realm.delete(client)
            } ) != nil) {
            indexClient = -1
            completion("Клиент удален")
            return
        }
        completion("Неожиданный поворот")
    }
    

    static func editClient(name: String, telephone: String?, vk: String?, additionalInfo: String?, photo: UIImage?, completion: @escaping (String) -> Void) {
        
        let client = Client()
        client.name = name
        client.telephone = telephone ?? ""
        client.additionalInfo = additionalInfo ?? ""
        var nsData = NSData()
        if (photo != nil) {
            nsData = NSData(data: photo!.pngData()!)
        }
        client.photo = nsData
        client.vk = vk ?? ""
        client.id = clients[indexClient].id
        client.procedures = clients[indexClient].procedures

        API.editContac(client: client) { _ in }
        
        if ((try? realm.write {
                realm.add(client, update: .modified)
            }) != nil) {
            completion("Информация изменена")
            return
        }
        completion("Неожиданный поворот")
    }

    static var isTempClient: Bool {
        get {
            return tempClient != nil
        }
    }
    
    static func clearTempClient() {
        tempClient = nil
    }
    
    static func getTempClient() -> Client{
        return tempClient!
    }
    
    static func addTempClient(name: String, telephone: String?, vk: String?, additionalInfo: String?, photo: UIImage?) {
        let client = Client()
        client.name = name
        client.telephone = telephone ?? ""
        client.additionalInfo = additionalInfo ?? ""
        var nsData = NSData()
        if (photo != nil) {
            nsData = NSData(data: photo!.pngData()!)
        }
        client.photo = nsData
        client.vk = vk ?? ""
        tempClient = client
    }
    //    
    
    //Section Procedure
    
    static var isSelectProcedure: Bool {
        get {
            return (indexProcedure >= 0)
        }
    }
    
    static var selectProcedure: Record {
        get {
            let selClient = selectClient
            return selClient.procedures[indexProcedure]
        }
    }
    
    static func addProcedureToClient(title: String, text: String, date: NSDate, state: State, completion: @escaping (String) -> Void) {
        let procedure = Record()
        procedure.title = title
        procedure.date = date
        procedure.text = text
        procedure.state = state.rawValue
        let client = clients[indexClient]
        procedure.id = procedure.title + String(client.procedures.count)
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
        let oldProcedure = client.getActivProcedure()!
        let index = client.procedures.index(of: oldProcedure)!
        newProcedure.date = oldProcedure.date
        newProcedure.text = oldProcedure.text
        newProcedure.title = oldProcedure.title
        newProcedure.state = State.unactiv.rawValue
        
        if ((try? realm.write {
            client.procedures[index] = newProcedure
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
