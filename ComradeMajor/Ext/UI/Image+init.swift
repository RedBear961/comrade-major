//
//  Image+init.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 01.11.2022.
//

import SwiftUI

extension Image {
    
    public init?(from data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self.init(uiImage: image)
    }
}
