//
//  ComradeMajorApp.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import CoreData

@main
struct ComradeMajorApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ComradeMajor")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(viewModel: HomeViewModel())
                    .environment(\.managedObjectContext, context)
                    .tabItem {
                        Label("Главная", image: "tab_main_icon")
                            .foregroundColor(.cBlue)
                    }
                
                TemplatesView()
                    .tabItem {
                        Label("Шаблоны", image: "tab_templates_icon")
                            .foregroundColor(.cBlue)
                    }
                
                
                SettingsView()
                    .tabItem {
                        Label("Настройки", image: "tab_settings_icon")
                            .foregroundColor(.cBlue)
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                saveContext()
            }
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            try! context.save()
        }
    }
}
