//
//  ActivitiesView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 21/10/2025.
//

import SwiftUI
import CoreData

struct ActivitiesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showSettings: Bool = false
    
    @ObservedObject var viewModel: ActivitiesViewModel
    
    let margin: CGFloat = 16
    
    init(id: String) {
        _viewModel = ObservedObject(initialValue: ActivitiesViewModel(id: id))
    }

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.value, ascending: true)],
//        animation: .default)
//    private var dates: FetchedResults<Activity>

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: margin), GridItem(.flexible(), spacing: margin)], spacing: margin) {
                    ForEach(Character.alphabet, id: \.self) { char in
                        viewModel.view(for: char)
                    }
                }
                .padding(margin)
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
            .background(.red)
        }
    }
}

#Preview {
    ActivitiesView(id: "ABC123").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
