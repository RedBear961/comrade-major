//
//  CardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var isShowingSheet = false
    
    var body: some View {
        ScrollView() {
            CardHeaderFieldView(card: viewModel.card)
            
            Spacer()
                .frame(height: 16)
            
            ForEach(viewModel.card.fieldsArray) { field in
                switch field {
                case let field as CardAuthField:
                    RoundedBackground {
                        VStack {
                            CardLoginFieldView(viewModel: viewModel, login: field.login)
                            
                            Rectangle()
                                .foregroundColor(.cSeparator)
                                .frame(height: 0.5)
                                .padding(.leading, 16)
                            
                            CardPasswordFieldView(viewModel: viewModel, password: field.password)
                            
                            Rectangle()
                                .foregroundColor(.cSeparator)
                                .frame(height: 0.5)
                                .padding(.leading, 16)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Веб-сайт")
                                        .fMedium(.title2)
                                    
                                    Text(viewModel.card.domain)
                                        .fRegular(.body)
                                }
                                
                                Spacer()
                                
                                Button(action: {}, label: { Image("web_icon") })
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                        }
                    }
                default:
                    preconditionFailure("Неизвестный тип поля")
                }
                
                Spacer()
                    .frame(height: 16)
            }
            
            RoundedBackground {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Описание")
                        .fMedium(.title2)
                        .padding(.top, 8)
                    
                    Text(viewModel.card.detail)
                        .fRegular(.body)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Веб-аккаунт")
        .toolbar {
            Button(action: { isShowingSheet.toggle() }) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
            }
            .sheet(isPresented: $isShowingSheet) {
                EditCardView(
                    viewModel: EditCardViewModel(card: viewModel.card, managedObjectContext: managedObjectContext)
                ).environment(\.managedObjectContext, managedObjectContext)
            }
        }
    }
}

extension String {
    
    var asPassword: String {
        return String(repeating: "●", count: count)
    }
}

struct CardHeaderFieldView: View {
    
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

struct CardLoginFieldView: View {
    
    let viewModel: CardViewModel
    let login: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Логин")
                    .fMedium(.title2)
                
                Text(login)
                    .fRegular(.body)
            }
            
            Spacer()
            
            Button(action: {}, label: { Image("copy_icon") })
        }
        .padding(.top, 12)
        .padding(.horizontal, 16)
    }
}

struct CardPasswordFieldView: View {
    
    let viewModel: CardViewModel
    let password: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Пароль")
                    .fMedium(.title2)
                
                Text(viewModel.isShowPassword ? password : password.asPassword)
                    .fRegular(.body)
                
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { _ in
                        Rectangle()
                            .foregroundColor(.cGreen)
                            .frame(height: 3)
                    }
                }
                .padding(.vertical, 4)
                
                Text("Время взлома пароля: 13 дней")
                    .fRegular(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack {
                Spacer()
                
                Button(action: {}, label: { Image("view_on_icon") })
                
                Spacer()
                
                Button(action: {}, label: { Image("copy_icon") })
                
                Spacer()
            }
            .padding(.leading, 16)
        }
        .padding(.horizontal, 16)
    }
}

struct RoundedBackground<Content>: View where Content: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
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
}

struct CardView_Previews: PreviewProvider {
    
    @State static var card = PreviewContentProvider.shared().fullCard
    
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: card))
            .previewDevice("iPhone 12 mini")
    }
}
