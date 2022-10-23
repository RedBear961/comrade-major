//
//  MainVM.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import Combine

final class MainVM: ObservableObject {
    
//    @EnvironmentObject var cardCellObjectFactory: CardCellObjectFactory
    
    var cardCellObjectFactory = CardCellObjectFactory()
    
    @Published var cellObjects: [CardCellObject] = []
    
    var subscriptions: [AnyCancellable] = []
    
    init() {
        cardCellObjectFactory.cellObjects
            .receive(on: DispatchQueue.main)
            .sink { self.cellObjects = $0 }
            .store(in: &subscriptions)
    }
}
