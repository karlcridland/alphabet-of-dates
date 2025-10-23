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
                        Text(character.uppercased())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                )
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1.0/1.2, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
    }
    
}

#Preview {
    ActivitiesView(id: "ABC123").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
