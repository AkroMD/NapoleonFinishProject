import Foundation

extension NSDate {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.string(from: self as Date)
    }
    
    static func dateFromString(string: String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let date = dateFormatter.date(from: string)
        return date! as NSDate
    }
    
}
