//
//  CardSubject.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import CoreData
import Foundation
import SwiftUI
import KeychainAccess

@objc(Card)
public class Card: NSManagedObject, Identifiable {
    
    @objc public enum Template: Int32, CaseIterable, Identifiable {
        
        case account
        case bankCard
        case bankAccount
        
        public var asText: String {
            switch self {
            case .account:      return "Веб-аккаунт"
            case .bankCard:     return "Банковская карта"
            case .bankAccount:  return "Банковский счет"
            }
        }
        
        public var id: String {
            return self.asText
        }
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var domain: String
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var detail: String
    @NSManaged public var template: Template
    
    // MARK: - Override
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

@objc(AccountCard)
public class AccountCard: Card {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCard> {
        return NSFetchRequest<AccountCard>(entityName: "AccountCard")
    }
    
    @NSManaged public var login: String
    @Published public var password: String = "" {
        willSet {
            objectWillChange.send()
            try! Keychain.shared.set(password, key: id.uuidString)
        }
    }
    
    // MARK: - Override
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        self.password = (try? Keychain.shared.get(id.uuidString)) ?? ""
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.template = .account
    }
    
    public override func prepareForDeletion() {
        try! Keychain.shared.remove(id.uuidString)
    }
}
