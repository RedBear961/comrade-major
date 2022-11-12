//
//  DynamicFetchRequestView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 30.10.2022.
//

import SwiftUI
import CoreData

public struct DynamicFetchRequestView<T: NSManagedObject, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    public let content: (FetchedResults<T>) -> Content

    public var body: some View {
        self.content(fetchRequest)
    }

    public init(
        with predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder content: @escaping (FetchedResults<T>) -> Content
    ) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )
        self.content = content
    }
}

extension DynamicFetchRequestView where T: Card {

    public init(
        with searchText: String,
        @ViewBuilder content: @escaping (FetchedResults<T>) -> Content
    ) {
        var predicate: NSPredicate?
        
        if searchText.count > 0 {
            let format = "title CONTAINS[c] %@ OR domain CONTAINS[c] %@"
            predicate = NSPredicate(format: format, searchText, searchText)
        }
        
        self.init(
            with: predicate,
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Card.title, ascending: true)
            ],
            content: content
        )
    }
}
