//
//  HomeViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import Combine
import CoreData

public final class HomeViewModel: ObservableObject {
    
    @Published var template: Card.Template = .account
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func editView() -> some View {
        let card: Card
        switch template {
        case .account:
            card = accountCard()
        case .bankCard:
            card = accountCard()
        case .bankAccount:
            card = accountCard()
        }

        let viewModel = EditCardViewModel(
            card: card,
            managedObjectContext: managedObjectContext
        )
        return EditCardView(viewModel: viewModel)
            .environment(\.managedObjectContext, managedObjectContext)
    }
    
    func delete(_ indexSet: IndexSet, from cards: [Card]) {
        managedObjectContext.perform {
            indexSet.forEach { index in
                self.managedObjectContext.delete(cards[index])
            }
            
            try? self.managedObjectContext.save()
        }
    }
    
    // MARK: -
    
    func accountCard() -> Card {
        let authField = CardAuthField(context: managedObjectContext)
        authField.id = UUID()
        
        let card = Card(context: managedObjectContext)
        card.id = UUID()
        card.fields = [authField]
        card.template = .account
        authField.card = card
        
        return card
    }
}
