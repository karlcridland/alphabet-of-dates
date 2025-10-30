//
//  AuthenticationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 22/10/2025.
//

import SwiftUI
import CoreData
import AuthenticationServices

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    init() {
        _viewModel = ObservedObject(initialValue: AuthenticationViewModel())
    }
    
    var body: some View {
        VStack {
            Color(.lilac).ignoresSafeArea()
            

        SignInWithAppleButton(.signIn, onRequest: viewModel.configure, onCompletion: viewModel.handle)
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        AuthenticationView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
