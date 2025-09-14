//
//  UIFonts+.swift
//  Baraban
//
//  Created by никита уваров on 23.08.24.
//

import UIKit

extension UIFont {
    static var boldFont: UIFont {
        return UIFont(name: "Impact", size: 40) ?? UIFont.systemFont(ofSize: 40)
    }
    
    static var simpleFont: UIFont {
        return UIFont(name: "Chalkduster", size: 34) ?? UIFont.systemFont(ofSize: 34)
    }
    
    static var cursiveFont: UIFont {
        return UIFont(name: "HelveticaNeue", size: 34) ?? UIFont.systemFont(ofSize: 34)
    }
    
    static var textFont: UIFont {
        return UIFont(name: " ", size: 34) ?? UIFont.systemFont(ofSize: 34)
    }
    
    static var cursiveHardFont: UIFont {
        return UIFont(name: "Zapfino", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
}
