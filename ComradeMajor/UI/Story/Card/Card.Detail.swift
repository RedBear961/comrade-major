//
//  Card.Detail.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

extension CardView {
    
    struct CardDetailView: View {
        
        let detail: String
        
        var body: some View {
            RoundedBackground {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Описание")
                        .fMedium(.title2)
                        .padding(.top, 8)
                    
                    Text(detail)
                        .fRegular(.body)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
