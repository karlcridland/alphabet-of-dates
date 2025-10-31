//
//  ActivityViewMenu.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 31/10/2025.
//

import SwiftUI

struct ActivityViewMenu: View {
    
    @Binding var selected: ActivityViewSelection
    
    init(_ selected: Binding<ActivityViewSelection>) {
        _selected = selected
    }
    
    var body: some View {
        Menu("Settings", systemImage: selected.systemImage) {
            Text("Change Appearance")
            Divider()
            ForEach(ActivityViewSelection.allCases, id: \.rawValue) { selection in
                Button(selection.rawValue, systemImage: selection.systemImage) {
                    self.selected = selection
                }
            }
        }
        .menuStyle(.automatic)
    }
    
}
