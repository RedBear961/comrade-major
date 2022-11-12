//
//  EditCardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import Combine
import CoreData

open class EditCardViewModel<Model: Card>: ObservableObject {
    
    @Published public var card: Model
    @Published public var theme: Color
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    public init(card: Model) {
        self.card = card
        self.theme = .red
    }
}
