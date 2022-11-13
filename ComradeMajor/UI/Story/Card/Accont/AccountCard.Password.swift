//
//  AccountCard.Password.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

extension AccountCardView {
    
    struct PasswordFieldView: View {
        
        let viewModel: AccountCardViewModel
        let password: String
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Пароль")
                        .fMedium(.title2)
                    
                    Text(viewModel.isShowPassword ? password : password.asPassword)
                        .fRegular(.body)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { _ in
                            Rectangle()
                                .foregroundColor(.cGreen)
                                .frame(height: 3)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Text("Время взлома пароля: 13 дней")
                        .fRegular(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button(action: {}, label: { Image("view_on_icon") })
                    
                    Spacer()
                    
                    Button(action: {}, label: { Image("copy_icon") })
                    
                    Spacer()
                }
                .padding(.leading, 16)
            }
            .padding(.horizontal, 16)
        }
    }

}
