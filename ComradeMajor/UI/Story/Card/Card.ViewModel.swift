//
//  CardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI
import CoreData

open class CardViewModel<Model: Card>: ObservableObject {
    
    @Published public var card: Model
    
    var context: NSManagedObjectContext
    
    public init(card: Model, context: NSManagedObjectContext) {
        self.card = card
        self.context = context
    }
    
    func editView() -> some View {
        switch card {
        case let card as AccountCard:
            let viewModel = EditAccountCardViewModel(
                card: card,
                context: context,
                mode: .edit
            )
            return AnyView(EditAccountCardView(viewModel: viewModel))
                .environment(\.managedObjectContext, context)
            
        case let card as BankCard:
            let viewModel = EditBankCardViewModel(
                card: card,
                context: context,
                mode: .edit
            )
            return AnyView(EditBankCardView(viewModel: viewModel))
                .environment(\.managedObjectContext, context)
            
        default:
            preconditionFailure("Неизвестный тип модели \(card.self)")
        }
    }
}
