//
//  EditCardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import Combine
import CoreData

final class EditCardViewModel: ObservableObject {
    
    @Published var card: AccountCard
    @Published var theme: Color
    
    var managedObjectContext: NSManagedObjectContext
    
    init(card: AccountCard, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.card = card
        self.theme = .red
    }
}
