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
    
    @State var login: String = ""
    @State var password: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section(header: Text("Сведения о карточке")) {
                TextField("Имя", text: $viewModel.card.title)
                
                HStack(spacing: 0) {
                    Text("https://")
                        .foregroundColor(Color(uiColor: .placeholderText))
                    TextField("", text: $viewModel.card.domain)
                        .textInputAutocapitalization(.never)
                }
                
                ColorPicker("Тема", selection: $viewModel.theme)
            }.autocorrectionDisabled()
            
            Section(header: Text("Данные входа")) {
                TextField("Логин", text: $login)
                    .keyboardType(.emailAddress)
                HStack {
                    TextField("Пароль", text: $password)
                    Spacer()
                    Button(action: {
                        
                    }, label: { Image(systemName: "key") })
                }
            }.autocorrectionDisabled()
            
            Section(header: Text("Подробности")) {
                TextEditor(text: $viewModel.card.detail)
            }
            
            Section {
                VStack(alignment: .center) {
                    Button {
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
    }
}

struct EditAccountCardView_Provider: PreviewProvider {
    
    static var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    static var card: AccountCard {
        let card = AccountCard(context: context)
        card.title = "Yandex"
        card.domain = "yandex.ru"
        return card
    }
    
    static var previews: some View {
        EditCardView(viewModel: EditCardViewModel(card: card, managedObjectContext: context))
            .previewDevice("iPhone 12 mini")
    }
}
