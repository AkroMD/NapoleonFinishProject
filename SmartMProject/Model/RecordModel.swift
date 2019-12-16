
import RealmSwift

class Record: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var date = NSDate()
    @objc dynamic var id = ""
    @objc dynamic var state = State.activ.rawValue
    
}
