//
//  UITextField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

extension UITextField {
    
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
    
}
