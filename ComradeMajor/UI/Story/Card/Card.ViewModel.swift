//
//  CardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

public final class CardViewModel: ObservableObject {
    
    @Published public var card: Card
    @Published public var isShowPassword: Bool = false
    
    public init(card: Card) {
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
