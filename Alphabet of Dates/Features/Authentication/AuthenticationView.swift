//
//  AuthenticationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 22/10/2025.
//

import SwiftUI
import CoreData

struct AuthenticationView: View {
    var body: some View {
        VStack {
            
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Text("Sign In")
                #warning("TODO: Sign In button here")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthenticationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
