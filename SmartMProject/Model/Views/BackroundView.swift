import UIKit

class BackroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ProfileCompanyController.colorBack
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = ProfileCompanyController.colorBack
    }
    
}
