//
//  PreviewContentProvider.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import CoreData

final class PreviewContentProvider {
    
    private static var _instance: PreviewContentProvider?
    
    static func shared() -> PreviewContentProvider {
        if let _instance {
            return _instance
        }
        
        let instance = PreviewContentProvider()
        _instance = instance
        return instance
    }
    
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        self.container = NSPersistentContainer(name: "ComradeMajor")
        self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    lazy var accountCard: AccountCard = {
        let card = AccountCard(context: context)
        
        card.title = "Yandex"
        card.domain = "yandex.ru"
        
        return card
    }()
    
    lazy var fullAccountCard: AccountCard = {
        let card = accountCard
        
        card.detail = "Современные технологии достигли такого уровня, что консультация с широким активом выявляет срочную потребность вывода текущих активов."
        card.login = "i@gcheremnykh.ru"
        card.password = "uE@urn9!2"
        
        return card
    }()
}
