import UIKit
import RealmSwift

class PatternController {
    
    static var currentPattern = 1
    private static var realm: Realm!
    
    static var proceduresPattern: Results<PatternRecord> {
        get {
            return realm.objects(PatternRecord.self).filter("type = 1")
        }
    }
    static var notificationsPattern: Results<PatternRecord> {
        get {
            return realm.objects(PatternRecord.self).filter("type = 2")
        }
    }
    
    private init() {}
    
    static func load(realm: Realm) {
        self.realm = realm
        if (proceduresPattern.count == 0 && notificationsPattern.count == 0) {
            defaultPattern()
        }
    }
    
    static func defaultPattern() {
        addPatternProcedure(title: "Шаблон1", text: "Основная деятельность") { _ in }
        addPatternProcedure(title: "Шаблон2", text: "Подработка") { _ in }
        addPatternProcedure(title: "Шаблон3", text: "Редкие услуги") { _ in }
        addPatternNotification(title: "Шаблон1", text: "Компания Бизнес ФМ предлагает воспользоваться нашими услугами!") { _ in }
        addPatternNotification(title: "Шаблон2", text: "Вы давно не пользовались услугами нашей компании!") { _ in }
        addPatternNotification(title: "Шаблон3", text: "У вас на завтра назначена процедура") { _ in }
    }
    
    static func addPattern(type: Int, title: String, text: String?, completion: (String) -> Void) {
        let pattern = PatternRecord()
        pattern.text = text ?? ""
        pattern.title = title
        pattern.type = type
        if ((try? realm.write {
            realm.add(pattern)
            }) != nil) {
                completion("Шаблон добавлен")
        }
        completion("Неожиданный поворот")
    }
    
    static func deletePattern(index: Int, type: Int, completion: (String) -> Void) {
        
        let pattern: PatternRecord

        if (type == 1) {
            pattern = proceduresPattern[index]
        }
        else {
            pattern = notificationsPattern[index]
        }
        if ((try? realm.write {
            realm.delete(pattern)
            }) != nil) {
                completion("Шаблон удален")
        }
        completion("Неожиданный поворот")
    }
    
    static func editPattern(index: Int, type: Int, title: String, text: String?, completion: (String) -> Void) {
        let pattern: PatternRecord
        if (type == 1) {
            pattern = proceduresPattern[index]
        }
        else {
            pattern = notificationsPattern[index]
        }
        if ((try? realm.write {
            pattern.text = text ?? ""
            pattern.title = title
            }) != nil) {
                completion("Шаблон изменен")
        }
        completion("Неожиданный поворот")
    }
    
    static func addPatternProcedure(title: String, text: String?, completion: (String) -> Void) {
        addPattern(type: 1, title: title, text: text, completion: completion)
    }
    
    static func addPatternNotification(title: String, text: String?, completion: (String) -> Void) {
        addPattern(type: 2, title: title, text: text, completion: completion)
        
    }
        
    
}
