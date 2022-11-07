//
//  RoundedBackground.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

public struct RoundedBackground<Content>: View where Content: View {
    
    public let content: () -> Content
    
    public var body: some View {
        ZStack {
            content()
                .background(
                    Rectangle()
                        .fill(Color.cSectionBackground)
                        .cornerRadius(12)
                )
                .padding(.horizontal, 16)
        }
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
