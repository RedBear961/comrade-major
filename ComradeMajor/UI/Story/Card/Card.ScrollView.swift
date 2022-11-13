//
//  Card.ScrollView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import SwiftUI

public struct CardScrollView<Content, Model>: View where Content: View, Model: Card {
    
    @ObservedObject public var viewModel: CardViewModel<Model>
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var isShowingSheet = false
    
    private let content: () -> Content
    
    public var body: some View {
        ScrollView() {
            HeaderFieldView(card: viewModel.card)
            
            Spacer()
                .frame(height: 16)
            
            content()
            
            Spacer()
                .frame(height: 16)
            
            CardDetailView(detail: viewModel.card.detail)
        }
        .navigationTitle(viewModel.card.template.asText)
        .toolbar {
            Button(action: { isShowingSheet.toggle() }) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
            }
            .sheet(isPresented: $isShowingSheet) {
                viewModel.editView()
            }
        }
    }
    
    init(
        viewModel: CardViewModel<Model>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content
    }
}
