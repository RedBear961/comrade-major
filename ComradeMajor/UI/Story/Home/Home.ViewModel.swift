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
        switch template {
        case .account:
            return editAccountView()
        case .bankCard:
            return editAccountView()
        case .bankAccount:
            return editAccountView()
        }
    }
    
    func editAccountView() -> some View {
        let card = AccountCard(context: managedObjectContext)
        let viewModel = EditAccountCardViewModel(card: card)
        return EditAccountCardView(viewModel: viewModel)
    }
    
    func delete(_ indexSet: IndexSet, from cards: [Card]) {
        managedObjectContext.perform {
            indexSet.forEach { index in
                self.managedObjectContext.delete(cards[index])
            }
            
            try? self.managedObjectContext.save()
        }
    }
}
