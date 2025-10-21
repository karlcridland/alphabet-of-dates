//
//  Alphabet_of_DatesApp.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 21/10/2025.
//

import SwiftUI
import CoreData

@main
struct Alphabet_of_DatesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DatesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
