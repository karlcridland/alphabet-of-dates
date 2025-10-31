//
//  ActivityThumbnailView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 23/10/2025.
//

import SwiftUI
import CoreData

struct ActivityThumbnailView: View {
    
    let character: Character
    let activity: Activity?
    
    @Binding var viewStyle: ActivityViewSelection
    
    @State private var showActivityView: Bool = false
    
    init(_ character: Character, _ activity: Activity? = nil, _ viewStyle: Binding<ActivityViewSelection>) {
        self.character = character
        self.activity = activity
        _viewStyle = viewStyle
    }
    
    var body: some View {
        Button {
            showActivityView = true
        } label: {
            Rectangle()
                .fill(.frost)
                .overlay(
                    VStack {
                        if (viewStyle == .image) {
                            Text("Image")
                        }
                        else {
                        Spacer()
                        Text(character.uppercased())
                            .font(.playfairDisplay(size: 72))
                        Spacer()
                        Text("Test")
                            .font(.lerckerliOne(size: 20))
                        }
                    }
                    .padding(20)
                )
        }
        .foregroundStyle(.charcoal)
        .frame(maxWidth: .infinity)
        .aspectRatio(1.0/1.15, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 15)
        .navigationDestination(isPresented: $showActivityView) {
            ActivityView(character: character, activity: activity)
        }
    }
    
}

#Preview {
    ActivitiesView(id: "ABC123").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
