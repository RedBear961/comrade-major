//
//  EditCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI
import CoreData

struct EditCardView: View {
    
    @ObservedObject var viewModel: EditCardViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State var isSaveButtonPressed: Bool = false
    
    var body: some View {
        List {
            EditCardHeaderFieldView(card: $viewModel.card, theme: $viewModel.theme)
          
            ForEach($viewModel.card.fieldsArray, id: \.self) { field in
                switch field.wrappedValue {
                case is CardAuthField:
                    EditCardAuthFieldView(field: Binding(field: field))
                default:
                    preconditionFailure("Неизвестный тип поля")
                }
            }
            
            Section(header: Text("Подробности")) {
                TextEditor(text: $viewModel.card.detail)
            }
            
            Section {
                VStack(alignment: .center) {
                    Button {
                        isSaveButtonPressed.toggle()
                        try? managedObjectContext.save()
                        dismiss()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                        Text("Сохранить")
                            .foregroundColor(.white)
                            .fMedium(.title2)
                    }.buttonStyle(.borderedProminent)
                }
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Новая карточка")
        .navigationBarTitleDisplayMode(.inline)
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
