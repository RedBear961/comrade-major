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
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func cardView(with card: Card) -> some View {
        switch card {
        case let card as AccountCard:
            let viewModel = AccountCardViewModel(card: card, context: context)
            return AccountCardView(viewModel: viewModel)
                .environment(\.managedObjectContext, context)
        default:
            preconditionFailure("Неизвестный тип карточки \(card.self)")
        }
    }
    
    func editView() -> some View {
        switch template {
        case .account:
            return AnyView(editAccountView())
        case .bankCard:
            return AnyView(editBankCardView())
        case .bankAccount:
            return AnyView(editAccountView())
        }
    }
    
    func editAccountView() -> some View {
        let card = AccountCard(context: context)
        let viewModel = EditAccountCardViewModel(card: card, context: context, mode: .new)
        return EditAccountCardView(viewModel: viewModel)
    }
    
    func editBankCardView() -> some View {
        let card = BankCard(context: context)
        let viewModel = EditBankCardViewModel(card: card, context: context, mode: .new)
        return EditBankCardView(viewModel: viewModel)
    }
    
    func delete(_ indexSet: IndexSet, from cards: [Card]) {
        context.perform {
            indexSet.forEach { index in
                self.context.delete(cards[index])
            }
            
            try? self.context.save()
        }
    }
}
