//
//  AuthenticationViewModel.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 22/10/2025.
//

import Combine

class AuthenticationViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    
    init() {
    }
    
}
