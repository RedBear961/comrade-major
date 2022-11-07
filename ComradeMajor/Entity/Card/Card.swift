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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var domain: String
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var detail: String
    @NSManaged public var fields: NSOrderedSet
    
    public var fieldsArray: [CardField] {
        get { self.fields.array as! [CardField] }
        set { self.fields = NSOrderedSet(array: newValue) }
    }
}
