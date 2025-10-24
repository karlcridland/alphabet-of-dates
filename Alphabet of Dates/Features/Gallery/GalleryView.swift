//
//  GalleryView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 24/10/2025.
//

import SwiftUI

struct GalleryView: View {
    
    @ObservedObject var viewModel: GalleryViewModel
    
    init() {
        _viewModel = ObservedObject(initialValue: .init())
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                
            }
        }
        .frame(height: 120)
        .background(.charcoal)
    }
}
