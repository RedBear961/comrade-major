//
//  CardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

public struct CardView: View {
    
    @ObservedObject public var viewModel: CardViewModel
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var isShowingSheet = false
    
    public var body: some View {
        ScrollView() {
            HeaderFieldView(card: viewModel.card)
            
            Spacer()
                .frame(height: 16)
            
            ForEach(viewModel.card.fieldsArray) { field in
                switch field {
                case let field as CardAuthField:
                    RoundedBackground {
                        VStack {
                            LoginFieldView(viewModel: viewModel, login: field.login)
                            
                            Rectangle()
                                .foregroundColor(.cSeparator)
                                .frame(height: 0.5)
                                .padding(.leading, 16)
                            
                            PasswordFieldView(viewModel: viewModel, password: field.password)
                            
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

struct CardView_Previews: PreviewProvider {
    
    @State static var card = PreviewContentProvider.shared().fullCard
    
    static var previews: some View {
        CardView(viewModel: CardViewModel(card: card))
            .previewDevice("iPhone 12 mini")
    }
}
