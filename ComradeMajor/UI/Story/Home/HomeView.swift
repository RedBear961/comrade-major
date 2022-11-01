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
    @State var isShowingSheet = false
    
    var body: some View {
        NavigationView {
            DynamicFetchRequestView(with: searchText) { cards in
                List(cards, id: \.id) { card in
                    NavigationLink(destination: CardView(viewModel: CardViewModel())) {
                        HStack {
                            CardIcon(domain: card.domain, size: 32)
                            
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
                .navigationTitle("Главная")
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            }
            .toolbar {
                Button(action: { isShowingSheet.toggle() }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingSheet) {
                    EditCardView(
                        viewModel: EditCardViewModel(card: newCard(), managedObjectContext: managedObjectContext)
                    ).environment(\.managedObjectContext, managedObjectContext)
                }
            }
        }
    }
    
    func newCard() -> AccountCard {
        let card = AccountCard(context: managedObjectContext)
        card.id = UUID()
        return card
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel()).previewDevice("iPhone 12 mini")
    }
}
