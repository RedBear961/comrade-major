//
//  AccountCard.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import CoreData

@objc(AccountCard)
public class AccountCard: Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCard> {
        return NSFetchRequest<AccountCard>(entityName: "AccountCard")
    }
}
