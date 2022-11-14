//
//  AccountCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 13.11.2022.
//

import SwiftUI

public struct AccountCardView: View {
    
    @ObservedObject public var viewModel: AccountCardViewModel
    
    public var body: some View {
        CardScrollView(viewModel: viewModel) {
            RoundedBackground {
                VStack {
                    LoginFieldView(viewModel: viewModel)
                    
                    Rectangle()
                        .foregroundColor(.cSeparator)
                        .frame(height: 0.5)
                        .padding(.leading, 16)
                    
                    PasswordFieldView(viewModel: viewModel)
                    
                    Rectangle()
                        .foregroundColor(.cSeparator)
                        .frame(height: 0.5)
                        .padding(.leading, 16)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Веб-сайт")
                                .fMedium(.title2)
                            
                            Text(viewModel.card.domain)
                                .fRegular(.body)
                        }
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://\(viewModel.card.domain)")!) {
                            Image("web_icon")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
            }
        }
    }
}

struct AccountCardView_Previews: PreviewProvider {
    
    @State static var card = PreviewContentProvider.shared().fullAccountCard

    static var previews: some View {
        AccountCardView(
            viewModel: AccountCardViewModel(
                card: card,
                context: PreviewContentProvider.shared().context
            )
        )
        .previewDevice("iPhone 12 mini")
    }
}
