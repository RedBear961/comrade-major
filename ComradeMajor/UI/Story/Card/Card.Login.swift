//
//  LoginFieldView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

extension CardView {
    
    struct LoginFieldView: View {
        
        let viewModel: CardViewModel
        let login: String
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Логин")
                        .fMedium(.title2)
                    
                    Text(login)
                        .fRegular(.body)
                }
                
                Spacer()
                
                Button(action: {}, label: { Image("copy_icon") })
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
        }
    }
}
