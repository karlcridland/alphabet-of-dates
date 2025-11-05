//
//  ActivityInfoView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/11/2025.
//

import SwiftUI

struct ActivityInfoView: View {
    
    let title, value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.caption)
        }
    }
    
}
