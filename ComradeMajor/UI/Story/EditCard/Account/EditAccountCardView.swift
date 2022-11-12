//
//  EditAccountCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import CoreData

public struct EditAccountCardView: View {
    
    @ObservedObject public var viewModel: EditAccountCardViewModel
    
    public var body: some View {
        EditCardListView(viewModel: viewModel) {
            Section(header: Text("Данные входа")) {
                TextField("Логин", text: $viewModel.card.login)
                    .keyboardType(.emailAddress)
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Пароль", text: $viewModel.card.password)
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

struct EditAccountCardView_Provider: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().accountCard

    static var previews: some View {
        EditAccountCardView(
            viewModel: EditAccountCardViewModel(
                card: card
            )
        )
        .previewDevice("iPhone 12 mini")
    }
}
