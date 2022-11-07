//
//  ComradeMajorApp.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import CoreData

@main
public struct ComradeMajorApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    public let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ComradeMajor")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            container.viewContext.undoManager = UndoManager()
        }
        
        return container
    }()
    
    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public var body: some Scene {
        WindowGroup {
            TabView {
                // Основной экран со списком всех карточек.
                HomeView(viewModel: HomeViewModel())
                    .environment(\.managedObjectContext, context)
                    .tabItem {
                        Label("Главная", image: "tab_main_icon")
                            .foregroundColor(.cBlue)
                    }
                
                // Экран со списком шаблонов карточек.
                TemplatesView()
                    .tabItem {
                        Label("Шаблоны", image: "tab_templates_icon")
                            .foregroundColor(.cBlue)
                    }
                
                // Экран настроек.
                SettingsView()
                    .tabItem {
                        Label("Настройки", image: "tab_settings_icon")
                            .foregroundColor(.cBlue)
                    }
            }
        }
    }
    
    public init() {}
    
    // MARK: - Core Data Saving support
    
    public func saveContext() {
        if context.hasChanges {
            try! context.save()
        }
    }
}
