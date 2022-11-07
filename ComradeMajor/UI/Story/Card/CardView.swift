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
            
            ForEach(viewModel.card.fieldsArray) { field in
                switch field {
                case let field as CardAuthField:
                    AuthFieldView(viewModel: viewModel, field: field)
                default:
                    preconditionFailure("Неизвестный тип поля")
                }
                
                Spacer()
                    .frame(height: 16)
            }
            
            CardDetailView(detail: viewModel.card.detail)
        }
        .navigationTitle("Веб-аккаунт")
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
    
    @State static var card = PreviewContentProvider.shared().fullCard
    
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: card))
            .previewDevice("iPhone 12 mini")
    }
}
