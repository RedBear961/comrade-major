//
//  Binding+CardField.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 03.11.2022.
//

import SwiftUI

extension Binding where Value: CardField {
    
    init(field: Binding<CardField>) {
        self.init(get: {
            field.wrappedValue as! Value
        }, set: {
            field.wrappedValue = $0
        })
    }
}
