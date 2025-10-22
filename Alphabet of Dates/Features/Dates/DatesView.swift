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
    @State private var showSettings: Bool = false

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.value, ascending: true)],
//        animation: .default)
//    private var dates: FetchedResults<Activity>

    var body: some View {
        NavigationStack {
            List {
//                ForEach(dates) { date in
//                    if let value = date.value {
//                        NavigationLink {
//                            Text("Date: \(value)")
//                        } label: {
//                            Text("Date: \(value)")
//                        }
//                    }
//                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings", systemImage: "gear") {
                        showSettings = true
                    }
                }
            }
            .navigationDestination(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    DatesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
