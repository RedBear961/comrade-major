//
//  AsyncImage.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 30.10.2022.
//

import SwiftUI

struct AsyncImage<Content>: View where Content: View {
    
    @State private var phase: AsyncImagePhase
    
    private let urlRequest: URLRequest?
    
    private let urlSession: URLSession
    
    private let scale: CGFloat
    
    private let transaction: Transaction
    
    private let content: (AsyncImagePhase) -> Content
    
    struct LoadingError: Error {}
    
    var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }
    
    init(
        urlRequest: URLRequest?,
        scale: CGFloat = 1,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.urlRequest = urlRequest
        self.urlSession = URLSession(configuration: .default)
        self.scale = scale
        self.transaction = transaction
        self.content = content
        
        self._phase = State(wrappedValue: .empty)
        
        if let urlRequest, let image = try? cachedImage(from: urlRequest) {
            self._phase = State(wrappedValue: .success(image))
        }
    }
    
    init(
        url: URL?,
        scale: CGFloat = 1,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(
            urlRequest: urlRequest,
            scale: scale,
            transaction: transaction,
            content: content
        )
    }
    
    @Sendable
    private func load() async {
        do {
            if let urlRequest {
                let (data, _) = try await urlSession.data(for: urlRequest)
                let image = try image(from: data)
                withAnimation(transaction.animation) {
                    phase = .success(image)
                }
            } else {
                withAnimation(transaction.animation) {
                    phase = .empty
                }
            }
        } catch {
            withAnimation(transaction.animation) {
                phase = .failure(error)
            }
        }
    }
    
    private func cachedImage(from request: URLRequest) throws -> Image? {
        guard let response = URLCache.shared.cachedResponse(for: request) else { return nil }
        return try image(from: response.data)
    }
    
    private func image(from data: Data) throws -> Image {
        guard let uiImage = UIImage(data: data) else {
            throw AsyncImage<Content>.LoadingError()
        }
        
        return Image(uiImage: uiImage)
    }
}
