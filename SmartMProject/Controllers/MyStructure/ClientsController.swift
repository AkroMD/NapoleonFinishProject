import Foundation

class ClientsController {
    
    //Клиенты для теста
    static func testClients() {
        addClient(name: "Любовь", telephone: "9191279329", vk: nil, additionalInfo: nil, photo: nil) {_ in }
        addClient(name: "Валера", telephone: "hgfhfghfg", vk: nil, additionalInfo: nil, photo: nil) {_ in }
        addClient(name: "Тамара", telephone: nil, vk: "vk://fdsf", additionalInfo: "длинные ногти", photo: nil) {_ in }
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
        let newid = clients.max(ofProperty: "id") as Int? ?? 0 + 1
        client.id = newid
        
        //Обновляем базу
        if ((try? realm.write {
                realm.add(client, update: .modified)
            }) != nil) {
            clients = realm.objects(Client.self)
            completion("Клиент добавлен")
            loadClients()
            return
        }

        completion("Неожиданный поворот")
    }

    static func deleteClient(index: Int, completion: @escaping (String) -> Void) {
        let client = clients[index]
        
        if ((try? realm.write {
                realm.delete(client)
            } ) != nil) {
            completion("Клиент удален")
            loadClients()
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

        if ((try? realm.write {
                realm.add(client, update: .modified)
            }) != nil) {
            clients = realm.objects(Client.self)
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

}
