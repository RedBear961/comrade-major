//
//  HeaderFieldView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI

extension EditCardView {
    
    public struct HeaderFieldView<T: Card>: View {
        
        @Binding public var card: T
        @Binding public var theme: Color
        
        public var body: some View {
            Section(header: Text("Сведения о карточке")) {
                TextField("Имя", text: $card.title)
                
                HStack(spacing: 0) {
                    Text("https://")
                        .foregroundColor(Color(uiColor: .placeholderText))
                    TextField("", text: $card.domain)
                        .textInputAutocapitalization(.never)
                }
                
                ColorPicker("Тема", selection: $theme)
            }.autocorrectionDisabled()
        }
    }
}

struct EditCardHeaderField_Previews: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().accountCard
    @State static var theme: Color = .red

    static var previews: some View {
        List {
            EditCardView.HeaderFieldView(card: $card, theme: $theme)
        }
    }
}
