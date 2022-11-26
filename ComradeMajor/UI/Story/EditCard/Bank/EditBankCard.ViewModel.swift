//
//  EditBankCard.ViewModel.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import CoreData

final class EditBankCardViewModel: EditCardViewModel<BankCard> {
    
    override init(card: BankCard, context: NSManagedObjectContext, mode: Mode) {
        super.init(card: card, context: context, mode: mode)
    }
    
    func expiresDidChange(oldValue: String, newValue: String) {
        var newValue = newValue
        
        if oldValue.identically(to: "[0-9]{2}"),
           newValue.identically(to: "[0-9]{3}") {
            newValue.insert("/", at: 2)
            card.expiresIn = newValue
        }
        
        if oldValue.identically(to: "[0-9]{2}/[0-9]"),
           newValue.identically(to: "[0-9]{2}/") {
            newValue.removeAll(where: { $0 == "/" } )
            card.expiresIn = newValue
        }
        
        if newValue.count == 6 {
            newValue.removeLast()
            card.expiresIn = newValue
        }
    }
}

extension String {
    
    mutating func insert(_ newElement: Character, at i: Int) {
        insert(newElement, at: index(startIndex, offsetBy: i))
    }
    
    func identically(to regex: String) -> Bool {
        guard let regex = try? Regex(regex),
              let match = firstMatch(of: regex),
              match.range.lowerBound == startIndex,
              match.range.upperBound == endIndex else {
            return false
        }
        
        return true
    }
}
