import UIKit
import Contacts

class ContactsTelephoneViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let contactsTelephone: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey] as [Any]
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {}
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {}
        }
        return(results)
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addContact(_ sender: Any) {
        
        if (tableView.indexPathForSelectedRow != nil) {
            let contact = contactsTelephone[ tableView.indexPathForSelectedRow!.row]
            let name = contact.familyName + " " + contact.givenName
            let telephone = contact.phoneNumbers.first?.value.stringValue
            var photo: UIImage? = nil
            if (contact.imageDataAvailable) {
                photo = UIImage(data: contact.thumbnailImageData!)
            }
            MainController.addTempClient(name: name, telephone: telephone, vk: nil, additionalInfo: nil, photo: photo)
            dismiss(animated: true)
        }
    }
      
    
}

extension ContactsTelephoneViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contactsTelephone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsTelephoneCell") as! ContactTelephoneTableViewCell
        let contact = contactsTelephone[indexPath.row]
        let name = contact.familyName + " " + contact.givenName
        let telephone = contact.phoneNumbers.first?.value.stringValue
        var photo = UIImage()
        if (contact.imageDataAvailable) {
            photo = UIImage(data: contact.thumbnailImageData!)!
        }
        
        cell.setup(name: name, telephone: telephone, photo: photo)
        return cell
    }
    
    
}
