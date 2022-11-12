//
//  AccountCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI

extension EditCardView {
    
    public struct AuthFieldView: View {
        
        @Binding public var card: AccountCard
        @ObservedObject public var viewModel: EditCardViewModel
        
        public var body: some View {
            Section(header: Text("Данные входа")) {
                TextField("Логин", text: $card.login)
                    .keyboardType(.emailAddress)
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Пароль", text: $card.password)
                        Spacer()
                        Button(action: {
                            
                        }, label: { Image(systemName: "key") })
                    }
                    Text("Время взлома: \(viewModel.entropy.time)")
                        .fRegular(.body)
                }
            }.autocorrectionDisabled()
        }
    }
}

struct EditCardAuthField_Previews: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().accountCard

    static var previews: some View {
        List {
            EditCardView.AuthFieldView(card: $card, viewModel: EditCardViewModel(card: card, managedObjectContext: PreviewContentProvider.shared().context))
        }
    }
}
