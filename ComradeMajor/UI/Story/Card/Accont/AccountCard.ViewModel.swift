//
//  AccountCard.ViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import SwiftUI
import CoreData

public final class AccountCardViewModel: CardViewModel<AccountCard> {
    
    @Published public var entropy: PasswordEntropy.AnalyzeResult
    
    public override init(card: AccountCard, context: NSManagedObjectContext) {
        self.entropy = PasswordEntropy().analyze(card.password)
        super.init(card: card, context: context)
    }
}
