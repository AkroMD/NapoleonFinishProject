//
//  ClientModel.swift
//  SmartMProject
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 AkroMD. All rights reserved.
//

import UIKit
import RealmSwift

class Client: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var additionalInfo = ""
    @objc dynamic var telephone = ""
    @objc dynamic var vk = ""
    @objc dynamic var photo = NSData()
    var procedures = List<Record>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func isActiveProcedure() -> Bool {
        for procedure in procedures {
            if procedure.state == State.activ.rawValue {
                return true
            }
        }
        return false
    }
    
    func getActivProcedure() -> Record? {
        
        for procedure in procedures {
            if procedure.state == State.activ.rawValue {
                return procedure
            }
        }
        return nil
    }
    
    func getLastProcedureText() -> String {
        if (procedures.count == 0) {
            return "Процедуры не проводились"
        }
        let procedure = getActivProcedure()
        let text: String
        if (procedure == nil) {
            text = "Последняя процедура: " + procedures.last!.date.toString()
        } else {
            text = "Следующая процедура: " + procedure!.date.toString()
        }
        return text
    }

}
