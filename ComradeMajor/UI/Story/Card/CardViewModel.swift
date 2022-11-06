//
//  CardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import Combine

final class CardViewModel: ObservableObject {
    
    @Published var card: Card
    @Published var isShowPassword: Bool = false
    
    init(card: Card) {
        self.card = card
    }
}
