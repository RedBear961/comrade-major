//
//  CardIcon.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 30.10.2022.
//

import SwiftUI

public struct CardIcon: View {
    
    private let domain: String?
    private let size: Int
    private let frame: CGFloat
    
    private var url: URL? {
        guard let domain else { return nil }
        
        let size = size * Int(UIScreen.main.scale)
        return URL(string: "https://www.google.com/s2/favicons?sz=\(size)&domain=\(domain)")
    }
    
    public init(
        domain: String? = nil,
        size: Int,
        frame: CGFloat? = nil
    ) {
        self.domain = domain
        self.size = size
        self.frame = frame ?? CGFloat(size)
    }
    
    public var body: some View {
        AsyncImage(url: url, scale: UIScreen.main.scale) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Image(systemName: "person.crop.circle")
                    .font(.system(size: frame))
            }
        }
        .frame(width: frame, height: frame)
    }
}
