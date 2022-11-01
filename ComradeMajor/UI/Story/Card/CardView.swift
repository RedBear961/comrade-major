//
//  CardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        List {
            Section {
                Header()
            }
            
            Section {
                LoginView()
                PasswordView()
                WebsiteView()
            }
            
            Section {
                DescriptionView()
            }
            
            Section {
                VStack(alignment: .center) {
                    Text("Создано: 19 января 2022")
                        .fRegular(.footnote)
                        .foregroundColor(.cGrayText)
                        .padding(.bottom, 2)
                    
                    Text("Изменено: 20 августа 2022")
                        .fRegular(.footnote)
                        .foregroundColor(.cGrayText)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparatorTint(Color.clear)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Сведения о карточке")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.insetGrouped)
//        VStack {
//
//        }
//        .navigationTitle("Сведения о карточке")
//        .navigationBarTitleDisplayMode(.inline)
//        .listStyle(.insetGrouped)
    }
}

//struct
/*
 List {
     Section {
         Header()
     }
     
     Section {
         LoginView()
         PasswordView()
         WebsiteView()
     }
     
     Section {
         DescriptionView()
     }
     
     Section {
         VStack(alignment: .center) {
             Text("Создано: 19 января 2022")
                 .fRegular(.footnote)
                 .foregroundColor(.cGrayText)
                 .padding(.bottom, 2)
             
             Text("Изменено: 20 августа 2022")
                 .fRegular(.footnote)
                 .foregroundColor(.cGrayText)
         }
     }
     .listRowBackground(Color.clear)
     .listRowSeparatorTint(Color.clear)
     .frame(maxWidth: .infinity)
 }
 .navigationTitle("Сведения о карточке")
 .navigationBarTitleDisplayMode(.inline)
 .listStyle(.insetGrouped)
 */

extension CardView {
    
    struct Header: View {
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Google")
                        .fMedium(.title)
                    
                    Button(action: {}) {
                        Image("favorite_off_icon")
                    }
                }.padding()
                
                Spacer()
                
                Image("yandex_logo_big")
            }
        }
    }
    
    struct LoginView: View {
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Логин")
                        .padding(.bottom, 1)
                        .fMedium(.title2)
                    
                    Text("g.cheremnykh@yandex.ru")
                        .fRegular(.body)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {}) {
                    Image("copy_icon")
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    struct PasswordView: View {
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Пароль")
                        .fMedium(.title2)
                        .padding(.top, 4)
                        .padding(.bottom, 1)
                    
                    Text("••••••••••")
                        .foregroundColor(.cWhite)
                    
                    HStack(spacing: 2) {
                        Rectangle()
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.green)
                        
                        Rectangle()
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.green)
                        
                        Rectangle()
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.green)
                        
                        Rectangle()
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.green)
                        
                        Rectangle()
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.green)
                    }
                    
                    Text("Время взлома: 11 дней")
                        .fRegular(.footnote)
                        .foregroundColor(.cWhite)
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                }.padding(.horizontal)
                
                Spacer()
                
                VStack {
                    Button(action: {}) {
                        Image("view_on_icon")
                    }.padding(.bottom)
                    
                    Button(action: {}) {
                        Image("copy_icon")
                    }
                }
            }
        }
    }
    
    struct WebsiteView: View {
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Веб-сайт")
                        .padding(.bottom, 1)
                        .fMedium(.title2)
                    
                    Text("yandex.ru")
                        .fRegular(.body)
                }.padding(.horizontal)
                
                Spacer()
                
                Button(action: {}) {
                    Image("web_icon")
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    struct DescriptionView: View {
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Описание")
                    .padding(.bottom, 1)
                    .fMedium(.title2)
                
                Text("Связка логин/пароль для основного аккаунта в Yandex")
                    .fRegular(.body)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(viewModel: CardViewModel()).previewDevice("iPhone 12 mini")
    }
}
