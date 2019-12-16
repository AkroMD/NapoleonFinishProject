
import UIKit

class ThemeApp {
    let colorBack: UIColor
    let colorButton: UIColor
    let colorMainText: UIColor
    let colorButtonText: UIColor
    let colorMainBack: UIColor
    
    init (colorBack: UIColor, colorMainBack: UIColor, colorButton: UIColor, colorMainText: UIColor, colorButtonText: UIColor) {
        self.colorMainBack = colorMainBack
        self.colorBack = colorBack
        self.colorButton = colorButton
        self.colorMainText = colorMainText
        self.colorButtonText = colorButtonText
    }
}
