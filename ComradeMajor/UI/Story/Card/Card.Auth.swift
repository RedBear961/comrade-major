//
//  Card.Auth.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

extension CardView {
    
    struct AuthFieldView: View {
        
        let viewModel: CardViewModel
        let field: CardAuthField
        
        var body: some View {
            RoundedBackground {
                VStack {
                    LoginFieldView(viewModel: viewModel, login: field.login)
                    
                    Rectangle()
                        .foregroundColor(.cSeparator)
                        .frame(height: 0.5)
                        .padding(.leading, 16)
                    
                    PasswordFieldView(viewModel: viewModel, password: field.password)
                    
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
                        
                        Button(action: {}, label: { Image("web_icon") })
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
            }
        }
    }
}
