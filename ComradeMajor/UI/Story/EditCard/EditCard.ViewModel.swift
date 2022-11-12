//
//  EditCardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import Combine
import CoreData

public final class EditCardViewModel: ObservableObject {
    
    @Published public var card: Card
    @Published public var theme: Color
    @Published public var entropy: PasswordEntropy.AnalyzeResult
    
    private var managedObjectContext: NSManagedObjectContext
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(card: Card, managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.card = card
        self.theme = .red
        self.entropy = PasswordEntropy().analyze((card as! AccountCard).password)
        
        $card
            .compactMap { $0 as? AccountCard }
            .receive(on: DispatchQueue.main)
            .sink { self.entropy = PasswordEntropy().analyze($0.password) }
            .store(in: &subscriptions)
    }
}
