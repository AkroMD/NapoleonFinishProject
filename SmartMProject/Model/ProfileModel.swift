import RealmSwift

class Profile: Object {
    
    @objc dynamic var login = ""
    @objc dynamic var appleID = ""
    @objc dynamic var themeID = 0
    
    override class func primaryKey() -> String? {
        return "appleID"
    }
    
}
