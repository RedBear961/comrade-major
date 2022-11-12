//
//  HomeView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI

public struct HomeView: View {
    
    @StateObject public var viewModel: HomeViewModel
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var searchText: String = ""
    @State private var isShowingEditView = false
    
    public var body: some View {
        NavigationView {
            DynamicFetchRequestView(with: searchText) { cards in
                List {
                    ForEach(cards, id: \.self) { card in
                        NavigationLink(
                            destination: CardView(viewModel: CardViewModel(card: card)).environment(\.managedObjectContext, managedObjectContext)
                        ) {
                            HStack {
                                CardIcon(domain: card.domain, size: 32)
                                    .padding(.vertical, 8)
                                
                                VStack(alignment: .leading) {
                                    Text(card.title)
                                        .fRegular(.title2)
                                    
                                    Text(card.domain)
                                        .fRegular(.body)
                                        .foregroundColor(.cGrayText)
                                        .textCase(.lowercase)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.delete(indexSet, from: cards.compactMap { $0 })
                    }
                }
                .navigationTitle("Главная")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            }
            .toolbar {
                Menu(content: {
                    ForEach(Card.Template.allCases) { template in
                        Button(action: {
                            viewModel.template = template
                            isShowingEditView.toggle()
                        }) {
                            Text(template.asText)
                        }
                        
                    }
                }, label: {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isShowingEditView) {
                    viewModel.editView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(managedObjectContext: PreviewContentProvider.shared().context))
            .previewDevice("iPhone 12 mini")
    }
}
