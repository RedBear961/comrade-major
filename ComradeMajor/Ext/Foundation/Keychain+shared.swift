//
//  Keychain+shared.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 12.11.2022.
//

import Foundation
import KeychainAccess

extension Keychain {
    
    static let shared = Keychain(service: "com.georgycheremnykh.comrademajor")
}
