//
//  EditCard.ListView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 12.11.2022.
//

import SwiftUI
import CoreData

public struct EditCardListView<Content, Model>: View where Content: View, Model: Card {
    
    @ObservedObject public var viewModel: EditCardViewModel<Model>
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    
    // Была ли нажата кнопка сохранение или закрытие происходит другим образом.
    @State private var isSaveButtonPressed: Bool = false
    private let content: () -> Content
    
    public var body: some View {
        NavigationView {
            List {
                // Заголовок карточки.
                HeaderFieldView(card: $viewModel.card, theme: $viewModel.theme)
                
                // Специфичные для карточки поля.
                content()
                
                // Подробности о карточке.
                Section(header: Text("Подробности")) {
                    TextEditor(text: $viewModel.card.detail)
                }
                
                // Кнопка сохранить.
                Section {
                    VStack(alignment: .center) {
                        Button() {
                            isSaveButtonPressed.toggle()
                            viewModel.onSave()
                        } label: {
                            Text("Сохранить")
                                .fMedium(.title2)
                        }
                        .buttonStyle(.borderedProminent)
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
            .onReceive(viewModel.didDismissSubject) { isDismiss in
                if isDismiss {
                    dismiss()
                }
            }
            .navigationBarTitle(viewModel.mode.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(
        viewModel: EditCardViewModel<Model>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content
    }
}
