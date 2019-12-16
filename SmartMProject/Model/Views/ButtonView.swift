import UIKit

class ButtonView: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ProfileCompanyController.colorButton
        self.tintColor = ProfileCompanyController.colorButtonText
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = ProfileCompanyController.colorButton
        self.tintColor = ProfileCompanyController.colorButtonText
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = ProfileCompanyController.colorBack.cgColor
    }

}
