//
//  HomeView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            DynamicFetchRequestView(withSearchText: searchText) { cards in
                List(cards, id: \.id) { object in
                    NavigationLink(destination: CardView(vm: CardVM())) {
                        HStack {
                            CardIcon(domain: object.domain, size: 32)
                                .frame(width: 44, height: 44)
                            
                            Text(object.title!)
                                .fRegular(.title2)
                                .padding()
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Главная")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $searchText)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel()).previewDevice("iPhone 12 mini")
    }
}
