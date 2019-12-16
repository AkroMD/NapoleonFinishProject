import Foundation
import RealmSwift
import CloudKit

class ProfileCompanyController {
    
    static var themeApp =
        [ThemeApp(colorBack: UIColor(red: 0.196, green: 0.349, blue: 0.33, alpha: 1),
                  colorMainBack: UIColor(red: 0.949, green: 0.910, blue: 0.780, alpha: 1),
                  colorButton: UIColor.systemBlue,
                  colorMainText: UIColor.black,
                  colorButtonText: UIColor.white),
         ThemeApp(colorBack: UIColor(red: 0.541, green: 0.420, blue: 0.439, alpha: 1),
                  colorMainBack: UIColor(red: 0.980, green: 0.922, blue: 0.925, alpha: 1),
                  colorButton: UIColor(red: 0.349, green: 0.251, blue: 0.349, alpha: 1),
                  colorMainText: UIColor.black,
                  colorButtonText: UIColor.white),
         ThemeApp(colorBack: UIColor(red: 0, green: 0.231, blue: 0.270, alpha: 1),
                  colorMainBack: UIColor(red: 0.925, green: 0.965, blue: 0.961, alpha: 1),
                  colorButton: UIColor(red: 0.278, green: 0.6, blue: 0.710, alpha: 1),
                  colorMainText: UIColor.black,
                  colorButtonText: UIColor.white)]
    
    private static var realm: Realm!

    private init() {}
    
    static var colorBack: UIColor {
        get {
            return themeApp[profile.themeID].colorBack
        }
    }
    
    static var colorMainBack: UIColor {
        get {
            return themeApp[profile.themeID].colorMainBack
        }
    }
    
    static var colorButton: UIColor {
        get {
            return themeApp[profile.themeID].colorButton
        }
    }
    
    static var colorMainText: UIColor {
        get {
            return themeApp[profile.themeID].colorMainText
        }
    }
    
    static var colorButtonText: UIColor {
        get {
            return themeApp[profile.themeID].colorButtonText
        }
    }
    
    static var profile: Profile {
        get {
            return realm.objects(Profile.self).first!
        }
    }
    
    static func load(realm: Realm) {
        self.realm = realm
        let value = realm.objects(Profile.self).first
        if (value == nil) {
            defaultValue()
        }
    }
    
    static func defaultValue() {
        let defProfile = Profile()
        defProfile.login = "Моя компания"
        defProfile.appleID = "default"
        defProfile.themeID = 0
        try? realm.write {
                realm.add(defProfile)
        }
        //На моей виртуалке не хочет заходить под логином, чтобы получить сертификат пользоваться ICloud
        //Поэтому приложению не хватает прав
//        let container = CKContainer.default()
//        container.accountStatus() { accountStatus, error in
//            if accountStatus == .available {
//                container.fetchUserRecordID() { recordID, error in
//                    let defProfile = Profile()
//                    defProfile.login = "Моя компания"
//                    defProfile.appleID = recordID?.recordName ?? "default"
//
//                    try? realm.write {
//                            realm.add(profile)
//                    }
//                }
//            }
//        }
    }
    
    static func setProfileInfo(login: String, themeID: Int, completion: (String) -> Void) {

        let newProfile = Profile()
        newProfile.login = login
        newProfile.themeID = themeID
        newProfile.appleID = profile.appleID
        
        if ((try? realm.write {
                realm.add(newProfile, update: .modified)
            }) != nil) {
            completion("Информация изменена")
            return
        }
        completion("Неожиданный поворот")
    }
    
}
