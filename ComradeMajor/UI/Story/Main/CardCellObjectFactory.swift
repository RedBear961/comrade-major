//
//  CardCellObjectFactory.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI
import Combine

final class CardCellObjectFactory: ObservableObject {
    
    var cellObjects = CurrentValueSubject<[CardCellObject], Never>([])
    
    init() {
        let objects = [
            CardCellObject(id: UUID(), name: "Yandex", favIcon: FavIcon(domain: "yandex.ru")),
            CardCellObject(id: UUID(), name: "Google", favIcon: FavIcon(domain: "google.com")),
            CardCellObject(id: UUID(), name: "Wikipedia", favIcon: FavIcon(domain: "wikipedia.org")),
            CardCellObject(id: UUID(), name: "VK", favIcon: FavIcon(domain: "vk.com")),
            CardCellObject(id: UUID(), name: "Microsoft", favIcon: FavIcon(domain: "microsoft.ru"))
        ]
        cellObjects.send(objects)
    }
}
