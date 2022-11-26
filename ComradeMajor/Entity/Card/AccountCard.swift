//
//  AccountCard.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import CoreData
import KeychainAccess
import SwiftUI

@objc(AccountCard)
public class AccountCard: Card {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCard> {
        return NSFetchRequest<AccountCard>(entityName: "AccountCard")
    }
    
    @NSManaged public var login: String
    @Published public var password: String = ""
    
    public override var template: Template {
        return .account
    }
    
    // MARK: - Override
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        self.password = (try? Keychain.shared.get(id.uuidString)) ?? ""
    }
    
    public override func prepareForDeletion() {
        try! Keychain.shared.remove(id.uuidString)
    }
    
    public func update(with plainCard: PlainAccountCard) {
        super.update(with: plainCard)
        
        self.login = plainCard.login
        self.password = plainCard.password
        
        try? Keychain.shared.set(password, key: id.uuidString)
    }
}

public struct PlainAccountCard: PlainCard {
    
    public let id: UUID
    
    public var domain: String
    public var title: String
    public var detail: String
    public var login: String
    public var password: String
    
    public init(from card: AccountCard) {
        self.id = card.id
        self.domain = card.domain
        self.title = card.title
        self.detail = card.detail
        self.login = card.login
        self.password = card.password
    }
}
