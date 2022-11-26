//
//  CardSubject.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import CoreData

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
    
    public var template: Template {
        preconditionFailure("Этот метод должен быть переопределен в наследнике!")
    }
    
    // MARK: - Override
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
    public func update(with plainCard: PlainCard) {
        self.domain = plainCard.domain
        self.title = plainCard.title
        self.detail = plainCard.detail
    }
}

public protocol PlainCard {
    
    var id: UUID { get }
    var domain: String { get }
    var title: String { get }
    var detail: String { get }
}

struct PlainBankCard: PlainCard {
    
    let id: UUID
    
    var domain: String
    var title: String
    var detail: String
}
