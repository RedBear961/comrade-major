//
//  BankCardView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 14.11.2022.
//

import SwiftUI
import CoreData

struct BankCardView: View {
    
    @ObservedObject public var viewModel: BankCardViewModel
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    var body: some View {
        CardScrollView(viewModel: viewModel) {
            Text("")
        }
    }
}

struct BankCardView_Previews: PreviewProvider {
    
    @State static var card = PreviewContentProvider.shared().fullBankCard
    
    static var previews: some View {
        BankCardView(
            viewModel: BankCardViewModel(
                card: card,
                context: PreviewContentProvider.shared().context
            )
        )
    }
}
