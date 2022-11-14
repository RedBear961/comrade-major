//
//  EditAccountCard.ViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 12.11.2022.
//

import SwiftUI
import Combine
import CoreData

public final class EditAccountCardViewModel: EditCardViewModel<AccountCard> {
    
    @Published public var entropy: PasswordEntropy.AnalyzeResult
    
    private var subscriptions = Set<AnyCancellable>()
    
    public override init(card: AccountCard, context: NSManagedObjectContext, mode: Mode) {
        self.entropy = PasswordEntropy().analyze(card.password)
        super.init(card: card, context: context, mode: mode)
        
        $card
            .receive(on: DispatchQueue.main)
            .sink { self.entropy = PasswordEntropy().analyze($0.password) }
            .store(in: &subscriptions)
    }
    
    public override func onSave() {
        super.onSave()
    }
}
