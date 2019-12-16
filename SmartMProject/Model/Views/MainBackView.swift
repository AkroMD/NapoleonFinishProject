import UIKit

class MainBackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = ProfileCompanyController.colorMainBack
        self.layer.cornerRadius = 200
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
    }

}
