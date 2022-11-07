//
//  CardSubject.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import CoreData
import Foundation
import SwiftUI

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
    @NSManaged public var fields: NSOrderedSet
    @NSManaged public var template: Template
    
    public var fieldsArray: [CardField] {
        get { self.fields.array as! [CardField] }
        set { self.fields = NSOrderedSet(array: newValue) }
    }
}
