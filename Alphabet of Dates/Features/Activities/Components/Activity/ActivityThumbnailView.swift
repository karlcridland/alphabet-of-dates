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
    
    init(character: Character, activity: Activity? = nil) {
        self.character = character
        self.activity = activity
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .overlay(
                    VStack {
                        Spacer()
                        Text(character.uppercased())
                            .font(.playfairDisplay(size: 72))
                        Spacer()
                        Text("test")
                    }
                    .padding(20)
                )
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1.0/1.15, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 15)
    }
    
}

#Preview {
    ActivitiesView(id: "ABC123").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
