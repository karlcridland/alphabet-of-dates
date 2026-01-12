//
//  AuthenticationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 22/10/2025.
//

import SwiftUI
import FirebaseCore
import CoreData
import AuthenticationServices

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    init(DEBUG_MODE: Bool = false) {
        _viewModel = ObservedObject(initialValue: AuthenticationViewModel(DEBUG_MODE: DEBUG_MODE))
    }
    
    var body: some View {
        ZStack {
            Color(.lilac).ignoresSafeArea()
            VStack {
                Spacer()
                SignInWithAppleButton(.signIn, onRequest: viewModel.configure, onCompletion: viewModel.handle)
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        AuthenticationView(DEBUG_MODE: true).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
