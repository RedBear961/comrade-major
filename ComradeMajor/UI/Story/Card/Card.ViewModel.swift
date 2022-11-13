//
//  CardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

open class CardViewModel<Model: Card>: ObservableObject {
    
    @Published public var card: Model
    @Published public var isShowPassword: Bool = false
    
    public init(card: Model) {
        self.card = card
    }
    
    func editView() -> some View {
        switch card {
        case let card as AccountCard:
            let viewModel = EditAccountCardViewModel(card: card)
            return EditAccountCardView(viewModel: viewModel)
        default:
            preconditionFailure("Неизвестный тип модели \(card.self)")
        }
    }
}

public final class AccountCardViewModel: CardViewModel<AccountCard> {
    
}
