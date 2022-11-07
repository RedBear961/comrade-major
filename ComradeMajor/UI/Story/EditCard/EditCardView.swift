//
//  EditCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import CoreData

public struct EditCardView: View {
    
    @ObservedObject public var viewModel: EditCardViewModel
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    
    // Была ли нажата кнопка сохранение или закрытие происходит другим образом.
    @State private var isSaveButtonPressed: Bool = false
    
    public var body: some View {
        List {
            // Заголовок карточки.
            HeaderFieldView(card: $viewModel.card, theme: $viewModel.theme)
          
            // Набор всех полей карточки.
            ForEach($viewModel.card.fieldsArray, id: \.self) { field in
                switch field.wrappedValue {
                case is CardAuthField:
                    // Поле логина и пароля.
                    AuthFieldView(field: Binding(field: field))
                default:
                    preconditionFailure("Неизвестный тип поля")
                }
            }
            
            // Подробности о карточке.
            Section(header: Text("Подробности")) {
                TextEditor(text: $viewModel.card.detail)
            }
            
            // Кнопка сохранить.
            Section {
                VStack(alignment: .center) {
                    Button() {
                        isSaveButtonPressed.toggle()
                        try? managedObjectContext.save()
                        dismiss()
                    } label: {
                        Text("Сохранить")
                            .fMedium(.title2)
                    }.buttonStyle(.borderedProminent)
                }
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
        .onDisappear {}
        .onWillDisappear {
            if !isSaveButtonPressed {
                managedObjectContext.rollback()
            }
        }
    }
}

struct EditAccountCardView_Provider: PreviewProvider {

    @State static var card = PreviewContentProvider.shared().card

    static var previews: some View {
        EditCardView(
            viewModel: EditCardViewModel(
                card: card,
                managedObjectContext: PreviewContentProvider.shared().context
            )
        )
        .previewDevice("iPhone 12 mini")
    }
}
