import UIKit

class SectionView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = ProfileCompanyController.colorBack.cgColor
    }

}
