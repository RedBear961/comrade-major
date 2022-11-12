//
//  CardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

public struct CardView: View {
    
    @ObservedObject public var viewModel: CardViewModel
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var isShowingSheet = false
    
    public var body: some View {
        ScrollView() {
            HeaderFieldView(card: viewModel.card)
            
            Spacer()
                .frame(height: 16)
            
            switch viewModel.card {
            case let card as AccountCard:
                AccountCardView(viewModel: viewModel, card: card)
            default:
                preconditionFailure("Неизвестный тип поля")
            }
            
            CardDetailView(detail: viewModel.card.detail)
        }
        .navigationTitle(viewModel.card.template.asText)
        .toolbar {
            Button(action: { isShowingSheet.toggle() }) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
            }
            .sheet(isPresented: $isShowingSheet) {
                EditCardView(
                    viewModel: EditCardViewModel(card: viewModel.card, managedObjectContext: managedObjectContext)
                ).environment(\.managedObjectContext, managedObjectContext)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().fullAccountCard

    static var previews: some View {
        CardView(viewModel: CardViewModel(card: card))
            .previewDevice("iPhone 12 mini")
    }
}
