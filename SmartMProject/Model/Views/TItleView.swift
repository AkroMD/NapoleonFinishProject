
import UIKit

class TItleView: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = ProfileCompanyController.colorBack
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.textColor = ProfileCompanyController.colorBack
    }

}
