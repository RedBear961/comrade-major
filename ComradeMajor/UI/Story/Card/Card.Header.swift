//
//  HeaderFieldView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

extension CardScrollView {
    
    struct HeaderFieldView: View {
        
        let card: Card
        
        var body: some View {
            RoundedBackground {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(card.title)
                            .fMedium(.title)
                        
                        Button(action: {}, label: { Image("favorite_on_icon") })
                    }
                    .padding(.vertical, 8)
                    
                    Spacer()
                    
                    CardIcon(domain: card.domain, size: 32, frame: 44)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
