//
//  MainView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import CachedAsyncImage

struct CardCellObject: Identifiable {
    
    let id: UUID
    let name: String
    let favIcon: FavIcon
}

struct MainView: View {
    
    @StateObject var vm: MainVM
    
    @State var searchText: String = ""
    
    var cellObjects: [CardCellObject] {
        if searchText.isEmpty {
            return vm.cellObjects
        } else {
            return vm.cellObjects.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(cellObjects, id: \.id) { object in
                NavigationLink(destination: CardView()) {
                    HStack {
                        CachedAsyncImage(url: object.favIcon.asURL(96), scale: 3) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 32, height: 32)
                        
                        Text(object.name)
                            .padding()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText)
            .navigationTitle("Главная")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(vm: MainVM())
    }
}
