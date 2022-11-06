//
//  EditCardHeaderFieldView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI

struct EditCardHeaderFieldView: View {
    
    @Binding var card: Card
    @Binding var theme: Color
    
    var body: some View {
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

struct EditCardHeaderField_Previews: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().card
    @State static var theme: Color = .red

    static var previews: some View {
        List {
            EditCardHeaderFieldView(card: $card, theme: $theme)
        }
    }
}
