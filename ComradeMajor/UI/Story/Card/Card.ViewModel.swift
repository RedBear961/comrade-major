//
//  CardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import Combine

public final class CardViewModel: ObservableObject {
    
    @Published public var card: Card
    @Published public var isShowPassword: Bool = false
    
    public init(card: Card) {
        self.card = card
    }
}
