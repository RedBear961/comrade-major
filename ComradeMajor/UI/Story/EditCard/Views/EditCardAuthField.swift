//
//  EditCardAuthFieldView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI

struct EditCardAuthFieldView: View {
    
    @Binding var field: CardAuthField
    
    var body: some View {
        Section(header: Text("Данные входа")) {
            TextField("Логин", text: $field.login)
                .keyboardType(.emailAddress)
            HStack {
                TextField("Пароль", text: $field.password)
                Spacer()
                Button(action: {
                    
                }, label: { Image(systemName: "key") })
            }
        }.autocorrectionDisabled()
    }
}

struct EditCardAuthField_Previews: PreviewProvider {
    
    @State static var field = PreviewContentProvider.shared().card.fields.array.first as! CardAuthField
    
    static var previews: some View {
        List {
            EditCardAuthFieldView(field: $field)
        }
    }
}
