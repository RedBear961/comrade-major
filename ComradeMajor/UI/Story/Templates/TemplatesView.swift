//
//  TemplatesView.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 21.10.2022.
//

import SwiftUI

struct TemplatesView: View {
    
    var body: some View {
        ZStack {
            Color.cBackground.edgesIgnoringSafeArea(.all)
            Text("Hello, world!")
                .padding()
        }
    }
}

struct TemplatesView_Previews: PreviewProvider {
    
    static var previews: some View {
        TemplatesView()
    }
}
