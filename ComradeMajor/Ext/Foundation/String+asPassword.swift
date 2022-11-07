//
//  String+asPassword.swift
//  ComradeMajor
//
//  Created by Георгий Черемных on 07.11.2022.
//

extension String {
    
    public var asPassword: String {
        return String(repeating: "●", count: count)
    }
}
