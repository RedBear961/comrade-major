//
//  AccountCard.Password.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI
import AlertToast

extension AccountCardView {
    
    struct PasswordFieldView: View {
        
        let viewModel: AccountCardViewModel
        
        @State private var isShowPassword = false
        @State private var isShowToast = false
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Пароль")
                        .fMedium(.title2)
                    
                    Text(isShowPassword ? viewModel.card.password : viewModel.card.password.asPassword)
                        .fRegular(.body)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { _ in
                            Rectangle()
                                .foregroundColor(.cGreen)
                                .frame(height: 3)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    Text("Время взлома пароля: \(viewModel.entropy.time)")
                        .fRegular(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Button(action: {
                        isShowPassword.toggle()
                    }, label: { Image("view_on_icon") })
                    Spacer()
                    Button(action: {
                        isShowToast.toggle()
                        UIPasteboard.general.setValue(
                            viewModel.card.password,
                            forPasteboardType: "public.plain-text"
                        )
                    }, label: { Image("copy_icon") })
                    Spacer()
                }
                .padding(.leading, 16)
            }
            .padding(.horizontal, 16)
            .toast(isPresenting: $isShowToast) {
                AlertToast(displayMode: .hud, type: .regular, title: "Скопировано!")
            }
        }
    }
}
