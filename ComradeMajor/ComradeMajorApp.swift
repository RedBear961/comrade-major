//
//  ComradeMajorApp.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI

@main
struct ComradeMajorApp: App {
    
    init() {
        // Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITableView.appearance().sectionFooterHeight = 0
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MainView(vm: MainVM())
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
    }
}
