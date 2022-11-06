//
//  CardIcon.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 30.10.2022.
//

import SwiftUI

struct CardIcon: View {
    
    let domain: String?
    let size: Int
    let frame: CGFloat
    
    init(domain: String? = nil, size: Int, frame: CGFloat? = nil) {
        self.domain = domain
        self.size = size
        self.frame = frame ?? CGFloat(size)
    }
    
    var url: URL? {
        guard let domain else { return nil }
        
        let size = size * Int(UIScreen.main.scale)
        return URL(string: "https://www.google.com/s2/favicons?sz=\(size)&domain=\(domain)")
    }
    
    var body: some View {
        AsyncImage(url: url, scale: UIScreen.main.scale) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.blue
            }
        }
        .frame(width: frame, height: frame)
    }
}
