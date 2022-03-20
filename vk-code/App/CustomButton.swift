import Foundation
import UIKit

class CustomButton {
    
    init(title: String, titleColor: UIColor, frame: CGRect) {
        self.title = title
        self.titleColor = titleColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String
    var titleColor: UIColor
}


