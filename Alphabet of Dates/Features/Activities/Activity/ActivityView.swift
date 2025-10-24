//
//  ActivityView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 24/10/2025.
//

import SwiftUI
import CoreData

struct ActivityView: View {
    
    @ObservedObject var viewModel: ActivityViewModel
    
    init(character: Character, activity: Activity?) {
        _viewModel = ObservedObject(initialValue: ActivityViewModel(character: character, activity: activity))
    }
    
    init(activity: Activity) {
        _viewModel = ObservedObject(initialValue: ActivityViewModel(character: activity.character, activity: activity))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GalleryView()
            Text(viewModel.activity?.title ?? "Edit Activity")
                .font(Font.title.weight(.semibold))
                .padding()
            Spacer()
        }
        .toolbar {
            ToolbarItemGroup {
                Button("Share", systemImage: "square.and.arrow.up") {
                    
                }
                Menu("Settings", systemImage: "ellipsis") {
                    Button("Edit Activity", systemImage: "slider.horizontal.3") {
                        
                    }
                    Button("Edit Date", systemImage: "calendar") {
                        
                    }
                    Divider()
                    Button("Add Image", systemImage: "photo.badge.plus") {
                        
                    }
                }
                .menuStyle(.button)
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        let activity = Activity(id: "ABC123", character: "C", title: "Camping")
        ActivityView(character: "A", activity: nil).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

