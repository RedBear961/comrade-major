//
//  TextField+filteredText.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 13.11.2022.
//

import SwiftUI
import Combine

extension TextField {
    
    enum AllowedCharacters: String {
        
        case password = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()"
    }
    
    func filteredText(_ text: Binding<String>, allowed: AllowedCharacters) -> some View {
        self
            .onReceive(Just(text)) { newValue in
                let wrapped = newValue.wrappedValue
                let text = wrapped.filter { allowed.rawValue.contains($0) }
                
                if text != wrapped {
                    newValue.wrappedValue = text
                }
            }
    }
}
