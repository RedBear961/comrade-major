//
//  EditCardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import Combine
import CoreData

public final class EditCardViewModel: ObservableObject {
    
    @Published public var card: Card
    @Published public var theme: Color
    
    private var managedObjectContext: NSManagedObjectContext
    
    public init(card: Card, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.card = card
        self.theme = .red
    }
}
