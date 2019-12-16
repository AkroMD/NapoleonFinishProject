import UIKit


class Message {
        
    static func message(title: String, message: String, presentationController: UIViewController, sourceView: UIView, completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: { action in
            if (completion != nil) { completion!() }
        }))

        presentationController.present(alertController, animated: true)
    }
    
}
