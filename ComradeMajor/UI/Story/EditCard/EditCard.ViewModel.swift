//
//  EditCardViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import Combine
import CoreData

open class EditCardViewModel<Model: Card>: ObservableObject {
    
    public enum Mode {
        
        case new
        case edit
        
        var navigationTitle: String {
            switch self {
            case .new:  return "Новая карточка"
            case .edit: return "Редактировать карточку"
            }
        }
    }
    
    @Published public var card: Model
    @Published public var theme: Color
    @Published public var mode: Mode
    
    public var didDismissSubject = PassthroughSubject<Bool, Never>()
    
    var context: NSManagedObjectContext
    
    public init(card: Model, context: NSManagedObjectContext, mode: Mode) {
        self.card = card
        self.theme = .red
        self.context = context
        self.mode = mode
    }
    
    public func onSave() {
        try! context.save()
        didDismissSubject.send(true)
    }
}
