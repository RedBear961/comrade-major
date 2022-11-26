//
//  EditBankCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import SwiftUI
import Combine

struct EditBankCardView: View {
    
    @ObservedObject public var viewModel: EditBankCardViewModel
    
    var body: some View {
        EditCardListView(viewModel: viewModel) {
            Section(header: Text("Данные карты")) {
                TextField("XXXX-XXXX-XXXX-XXXX", text: $viewModel.card.number)
                    .keyboardType(.numberPad)
                
                HStack {
                    Text("Действительна до:")
                    
                    Spacer()
                    
                    TextField("MM/YY", text: $viewModel.card.expiresIn)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.card.expiresIn) { [oldValue = viewModel.card.expiresIn] newValue in
                            viewModel.expiresDidChange(oldValue: oldValue, newValue: newValue)
                        }
                }
            }
        }
    }
}

struct CardValidToView: View {
    
    final class CardValidViewModel: ObservableObject {
        
        @Published var month: String = ""
        @Published var year: String = ""
        @Binding var validTo: String
        
        init(validTo: Binding<String>) {
            self._validTo = validTo
            
        }
    }
    
    @ObservedObject public var viewModel: CardValidViewModel
    
    @Binding public var valid: String
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Text("")
                TextField("", text: $viewModel.month)
            }
            
            Text("/")
            TextField("00", text: $viewModel.year)
        }
    }
    
    init(validTo: Binding<String>) {
        self._valid = validTo
        self.viewModel = CardValidViewModel(validTo: validTo)
    }
}

struct EditBankCardView_Previews: PreviewProvider {
    
    @State static var card = PreviewContentProvider.shared().bankCard
    
    static var previews: some View {
        EditBankCardView(
            viewModel: EditBankCardViewModel(
                card: card,
                context: PreviewContentProvider.shared().context,
                mode: .new
            )
        )
        .previewDevice("iPhone 12 mini")
    }
}
