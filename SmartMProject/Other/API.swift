import Foundation


typealias JSON = [String : Any]

enum API {
    
    static var identifier: String { "SMART" }
    static var baseURL: String {
        "https://ios-napoleonit.firebaseio.com/data/\(identifier)/"
    }
    
    private enum KeysClient: String {
        case name = "name"
        case tel = "tel"
        case additionInfo = "additionalInfo"
        case vk = "vk"
        case procedures = "procedures"
        case photo = "photo"
    }
    
    private enum KeysProcedure: String {
        case title = "title"
        case text = "text"
        case date = "date"
        case state = "state"
    }
    
    private enum KeysProfile: String {
        case login = "login"
    }
    
    static func loadContacts(completion: @escaping ([Client]) -> Void) {
        let url = URL(string: baseURL + ".json")!
        let request = URLRequest(url: url)
        let storageName = ProfileCompanyController.profile.appleID
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON
            else { return }
            
            guard
                let baseJSON = json[storageName] as? JSON
                else { return }
            guard
                let clientsJSON = baseJSON["clients"] as? JSON
                else { return }
            
            var contacts = [Client]()
            print(clientsJSON)
            for client in clientsJSON {
                let newClient = Client()
                let dataIn = client.value as! JSON
                let data = dataIn.values.first! as! JSON
                newClient.id = client.key
                newClient.name = data[KeysClient.name.rawValue] as! String
                newClient.additionalInfo = data[KeysClient.additionInfo.rawValue] as! String
                newClient.telephone = data[KeysClient.tel.rawValue] as! String
                newClient.vk = data[KeysClient.vk.rawValue] as! String
                newClient.photo = NSData(base64Encoded: data[KeysClient.photo.rawValue] as! String, options: .ignoreUnknownCharacters) ?? NSData()
                if  let procedureJSON = data[KeysClient.procedures.rawValue] as? JSON {
                    for procedure in  procedureJSON {
                        let newProcedure = Record()
                        let dataProcedure = procedure.value as! JSON
                        newProcedure.id = procedure.key
                        newProcedure.title = dataProcedure[KeysProcedure.title.rawValue] as! String
                        newProcedure.text = dataProcedure[KeysProcedure.text.rawValue] as! String
                        newProcedure.date = NSDate.dateFromString(string: dataProcedure[KeysProcedure.date.rawValue] as! String)
                        newProcedure.state = dataProcedure[KeysProcedure.state.rawValue] as! String
                        newClient.procedures.append(newProcedure)
                        }
                }
                contacts.append(newClient)
            }
            
            DispatchQueue.main.async {
                completion(contacts)
            }
        }
        task.resume()
    }
    
    static func createContac(client: Client, completion: @escaping (Bool) -> Void) {

        let storageName = ProfileCompanyController.profile.appleID + "/clients/\(client.id)"
        let url = URL(string: baseURL + "/\(storageName).json")!
        var request = URLRequest(url: url)
        
        //Формируем JSON
        var procedures = [JSON]()
        var idProcedure = [String]()

        for procedure in client.procedures {
            let paramsProcedure = [
                KeysProcedure.title.rawValue: procedure.title,
                KeysProcedure.text.rawValue: procedure.text,
                KeysProcedure.date.rawValue: procedure.date.toString(),
                KeysProcedure.state.rawValue: procedure.state
                ]
            procedures.append(paramsProcedure)
            idProcedure.append(procedure.id)
        }
        
        let paramsProcedures = JSON(uniqueKeysWithValues: zip(idProcedure, procedures))
        
        let params: JSON = [
            KeysClient.name.rawValue: client.name,
            KeysClient.tel.rawValue: client.telephone,
            KeysClient.additionInfo.rawValue: client.additionalInfo,
            KeysClient.photo.rawValue: client.photo.base64EncodedString(options: .endLineWithCarriageReturn),
            KeysClient.vk.rawValue: client.vk,
            KeysClient.procedures.rawValue: paramsProcedures
            ]
        
        request.httpMethod = "POST"
        print(params)
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
    static func editContac(client: Client, completion: @escaping (Bool) -> Void) {

        let storageName = ProfileCompanyController.profile.appleID + "/clients"
        let url = URL(string: baseURL + "/\(storageName)/\(client.id)/.json")!
        var request = URLRequest(url: url)

        
        //Формируем JSON
        var procedures = [JSON]()
        var idProcedure = [String]()

        for procedure in client.procedures {
            let paramsProcedure = [
                KeysProcedure.title.rawValue: procedure.title,
                KeysProcedure.text.rawValue: procedure.text,
                KeysProcedure.date.rawValue: procedure.date.toString(),
                KeysProcedure.state.rawValue: procedure.state
                ]
            procedures.append(paramsProcedure)
            idProcedure.append(procedure.id)
        }
        
        let paramsProcedures = JSON(uniqueKeysWithValues: zip(idProcedure, procedures))
        
        let params: JSON = [
            KeysClient.name.rawValue: client.name,
            KeysClient.tel.rawValue: client.telephone,
            KeysClient.additionInfo.rawValue: client.additionalInfo,
            KeysClient.photo.rawValue: client.photo.base64EncodedString(options: .endLineWithCarriageReturn),
            KeysClient.vk.rawValue: client.vk,
            KeysClient.procedures.rawValue: paramsProcedures
            ]
        
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }

    static func clearBase(completion: @escaping (Bool) -> Void) {
        let storageName = ProfileCompanyController.profile.appleID + "/clients"
        let url = URL(string: baseURL + "/\(storageName).json")!
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
    static func deleteContact(contactID: String, completion: @escaping (Bool) -> Void) {
        let storageName = ProfileCompanyController.profile.appleID + "/clients"
        let url = URL(string: baseURL + "/\(storageName)/\(contactID)/.json")!
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
}
