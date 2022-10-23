//
//  FavIcon.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 22.10.2022.
//

import Foundation

struct FavIcon {
    
    let domain: String
    
    func asURL(_ size: Int) -> URL? {
        return URL(string: "https://www.google.com/s2/favicons?sz=\(size)&domain=\(domain)")
    }
}
