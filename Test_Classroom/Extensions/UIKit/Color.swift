//
//  Color.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func searchColor() -> UIColor {
        return UIColor(red: 224, green: 244, blue: 231)
    }
    
    static func navigationLabelColor() -> UIColor {
        return UIColor(red: 179, green: 179, blue: 179)
    }
    
    static func statusInProcessColor() -> UIColor {
        return UIColor(red: 255, green: 122, blue: 88)
    }
    
    static func statusCompletedColor() -> UIColor {
        return UIColor(red: 126, green: 198, blue: 127)
    }
    
    static func statusNotStartedColor() -> UIColor {
        return UIColor(red: 113, green: 127, blue: 239)
    }
}
