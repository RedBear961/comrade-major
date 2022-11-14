//
//  AccountCard.Login.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI
import AlertToast

extension AccountCardView {
    
    struct LoginFieldView: View {
        
        let viewModel: AccountCardViewModel
        
        @State private var isShowToast = false
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Логин")
                        .fMedium(.title2)
                    
                    Text(viewModel.card.login)
                        .fRegular(.body)
                }
                
                Spacer()
                
                Button(action: {
                    isShowToast.toggle()
                    UIPasteboard.general.setValue(
                        viewModel.card.login,
                        forPasteboardType: "public.plain-text"
                    )
                }, label: { Image("copy_icon") })
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
            .toast(isPresenting: $isShowToast) {
                AlertToast(displayMode: .hud, type: .regular, title: "Скопировано!")
            }
        }
    }
}
