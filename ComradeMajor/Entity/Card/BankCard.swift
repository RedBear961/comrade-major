//
//  BankCard.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import Foundation

import CoreData
import KeychainAccess
import SwiftUI

@objc(BankCard)
public class BankCard: Card {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankCard> {
        return NSFetchRequest<BankCard>(entityName: "BankCard")
    }
    
    @NSManaged public var number: String
    @NSManaged public var expiresIn: String
    @NSManaged public var ownerName: String
    
    @Published public var cvc: String = "" {
        willSet {
            objectWillChange.send()
            try! Keychain.shared.set(cvc, key: id.uuidString)
        }
    }
    
    public override var template: Template {
        return .bankCard
    }
    
    // MARK: - Override
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        self.cvc = (try? Keychain.shared.get(id.uuidString)) ?? ""
    }
    
    public override func prepareForDeletion() {
        try! Keychain.shared.remove(id.uuidString)
    }
}
