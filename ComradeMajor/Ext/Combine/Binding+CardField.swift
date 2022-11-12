//
//  Binding+CardField.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 03.11.2022.
//

import SwiftUI

extension Binding where Value: Card {
    
    init(card: Binding<Card>) {
        self.init(get: {
            card.wrappedValue as! Value
        }, set: {
            card.wrappedValue = $0
        })
    }
}
