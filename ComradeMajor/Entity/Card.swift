//
//  Card.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

protocol CardSubject: Identifiable {
    
    var id: UUID { get }
    
    var name: String { get set }
    
    var image: Image? { get set }
    
    var fields: [CardField] { get set }
}

protocol CardField {
}

struct AccountCard: CardSubject {
    
    var id: UUID
    
    var name: String
    
    var image: Image?
    
    var fields: [CardField]
}

struct LoginField: CardField {
    
    var login: String
}

struct PasswordField: CardField {
    
    var password: String
}
