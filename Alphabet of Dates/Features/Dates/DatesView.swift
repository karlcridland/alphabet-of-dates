//
//  DatesView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 21/10/2025.
//

import SwiftUI
import CoreData

struct DatesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \AlphaDate.value, ascending: true)],
        animation: .default)
    private var dates: FetchedResults<AlphaDate>

    var body: some View {
        NavigationView {
            List {
                ForEach(dates) { date in
                    if let value = date.value {
                        NavigationLink {
                            Text("Date: \(value)")
                        } label: {
                            Text("Date: \(value)")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }
}

#Preview {
    DatesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
