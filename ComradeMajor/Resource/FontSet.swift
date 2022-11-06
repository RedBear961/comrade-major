//
//  Font.swift
//  VK
//
//  Created by Георгий Черемных on 16.10.2022.
//

import SwiftUI

struct FontModifier: ViewModifier {
    
    enum Style: CGFloat {
        case footnote = 13
        case body = 15
        case title = 21
        case title2 = 17
    }
    
    let font: String
    
    let style: Style
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(font, size: style.rawValue))
    }
}

extension View {
    
    func fRegular(_ style: FontModifier.Style) -> some View {
        modifier(FontModifier(font: "VKSansDisplay-Regular", style: style))
    }
    
    func fMedium(_ style: FontModifier.Style) -> some View {
        modifier(FontModifier(font: "VKSansDisplay-Medium", style: style))
    }
    
    func fDemibold(_ style: FontModifier.Style) -> some View {
        modifier(FontModifier(font: "VKSansDisplay-DemiBold", style: style))
    }
    
    func fBold(_ style: FontModifier.Style) -> some View {
        modifier(FontModifier(font: "VKSansDisplay-Bold", style: style))
    }
}
