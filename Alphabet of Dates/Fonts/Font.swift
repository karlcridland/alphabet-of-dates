//
//  Font.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 23/10/2025.
//

import SwiftUI

extension Font {
    
    private static var defaultSize: CGFloat {
        UIFont.preferredFont(forTextStyle: .body).pointSize
    }
    
    static func playfairDisplay(size: CGFloat) -> Font {
        Font.custom("PlayfairDisplay-Black", size: size)
    }
    
    static func lerckerliOne(size: CGFloat = defaultSize) -> Font {
        Font.custom("LeckerliOne-Regular", size: size)
    }
    
}
