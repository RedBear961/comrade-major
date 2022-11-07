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
    
    lazy var card: Card = {
        let card = Card(context: context)
        card.title = "Yandex"
        card.domain = "yandex.ru"
        
        let field = CardAuthField(context: context)
        field.id = UUID()
        field.card = card
        
        card.fields = [field]
        
        return card
    }()
    
    lazy var fullCard: Card = {
        let card = Card(context: context)
        card.title = "Yandex"
        card.domain = "yandex.ru"
        card.detail = "Идейные соображения высшего порядка, а также новая модель организационной деятельности обеспечивает широкому кругу (специалистов) участие в формировании соответствующий условий активизации."
        
        let field = CardAuthField(context: context)
        field.id = UUID()
        field.login = "i@gcheremnykh.ru"
        field.password = "uE@urn9!2"
        field.card = card
        
        card.fields = [field]
        
        return card
    }()
}
