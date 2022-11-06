//
//  CardField.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import CoreData

@objc(CardField)
public class CardField: NSManagedObject, Identifiable {
    
    @objc
    public enum Category: Int32 {
        
        case auth
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardField> {
        return NSFetchRequest<CardField>(entityName: "CardField")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var category: Category
    @NSManaged public var card: Card
}

@objc(CardAuthField)
public class CardAuthField: CardField {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardAuthField> {
        return NSFetchRequest<CardAuthField>(entityName: "CardAuthField")
    }
    
    @NSManaged public var login: String
    @NSManaged public var password: String
}
