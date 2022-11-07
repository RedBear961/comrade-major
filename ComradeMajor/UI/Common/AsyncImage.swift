//
//  AsyncImage.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 30.10.2022.
//

import SwiftUI

public struct AsyncImage<Content>: View where Content: View {
    
    @State private var phase: AsyncImagePhase
    
    private let urlRequest: URLRequest?
    
    private let urlSession = URLSession(configuration: .default)
    
    private let scale: CGFloat
    
    private let transaction: Transaction
    
    private let content: (AsyncImagePhase) -> Content
    
    public struct LoadingError: Error {}
    
    public var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }
    
    public init(
        url: URL?,
        scale: CGFloat = 1,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.scale = scale
        self.transaction = transaction
        self.content = content
        
        self._phase = State(wrappedValue: .empty)
        
        if let urlRequest,
           let response = URLCache.shared.cachedResponse(for: urlRequest),
           let image = Image(from: response.data) {
            withAnimation(transaction.animation) {
                self._phase = State(wrappedValue: .success(image))
            }
        }
    }
    
    @Sendable private func load() async {
        guard let urlRequest else {
            phase = .empty
            return
        }
        
        if let (data, _) = try? await urlSession.data(for: urlRequest),
           let image = Image(from: data) {
            withAnimation(transaction.animation) {
                phase = .success(image)
            }
        } else {
            withAnimation(transaction.animation) {
                phase = .failure(LoadingError())
            }
        }
    }
}
