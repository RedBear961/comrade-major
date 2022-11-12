//
//  WillDisappearHandler.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

import SwiftUI

public struct WillDisappearHandler: UIViewControllerRepresentable {
    
    public let onWillDisappear: () -> Void
    
    public func makeCoordinator() -> WillDisappearHandler.Coordinator {
        Coordinator(onWillDisappear: onWillDisappear)
    }

    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<WillDisappearHandler>
    ) -> UIViewController {
        context.coordinator
    }

    public func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<WillDisappearHandler>
    ) {}

    public final class Coordinator: UIViewController {
        
        public let onWillDisappear: () -> Void

        public init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

extension View {
    
    public func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        background(WillDisappearHandler(onWillDisappear: perform))
    }
}
